import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import '../domain/update_check.dart';
import '../domain/update_failures.dart';
import '../domain/update_models.dart';

/// How long a manifest lookup may take before the check reports a failure.
const manifestTimeout = Duration(seconds: 30);

const _maxRedirects = 5;

class UpdateClient implements ManifestSource {
  UpdateClient({http.Client? client, required this.manifestUrl})
    : _client = client ?? http.Client();

  final String manifestUrl;
  final http.Client _client;

  @override
  Future<UpdateManifest> fetchManifest() async {
    final response = await _send(
      () => _open(
        Uri.parse(manifestUrl),
        (detail) => UpdateManifestException(detail),
      ),
      timeout: manifestTimeout,
    );
    if (response.statusCode != 200) {
      final status = response.statusCode;
      await response.stream.drain<void>();
      throw UpdateManifestException('HTTP $status');
    }
    final body = await http.Response.fromStream(response);
    try {
      // Release assets are application/octet-stream. Response.body would
      // decode that as Latin-1 and corrupt a UTF-8 manifest.
      return parseUpdateManifest(utf8.decode(body.bodyBytes));
    } on FormatException catch (error) {
      throw UpdateManifestException(
        error.message.isEmpty ? 'Invalid update manifest' : error.message,
      );
    }
  }

  /// Downloads [url] to [destination] and checks [sha256].
  ///
  /// [onProgress] receives 0..1 when the server sends a length, otherwise null.
  Future<File> download({
    required String url,
    required String sha256,
    required File destination,
    void Function(double? progress)? onProgress,
  }) async {
    final response = await _send(
      () => _open(Uri.parse(url), (detail) => UpdateDownloadException(detail)),
    );
    if (response.statusCode != 200) {
      final status = response.statusCode;
      await response.stream.drain<void>();
      throw UpdateDownloadException('HTTP $status');
    }
    await destination.parent.create(recursive: true);
    final partial = File('${destination.path}.part');
    final sink = partial.openWrite();
    final total = response.contentLength ?? 0;
    var received = 0;
    try {
      await for (final chunk in response.stream) {
        received += chunk.length;
        sink.add(chunk);
        if (total > 0) {
          onProgress?.call(received / total);
        } else {
          onProgress?.call(null);
        }
      }
    } on Object catch (error) {
      await sink.close();
      if (partial.existsSync()) {
        await partial.delete();
      }
      if (error is UpdateDownloadException) {
        rethrow;
      }
      throw UpdateDownloadException('$error');
    }
    await sink.close();
    final digest = (await sha256Hash.bind(partial.openRead()).first).toString();
    if (digest.toLowerCase() != sha256.toLowerCase()) {
      await partial.delete();
      throw const UpdateChecksumException();
    }
    if (destination.existsSync()) {
      await destination.delete();
    }
    return partial.rename(destination.path);
  }

  /// GET [url] without asking the HTTP client to follow redirects.
  ///
  /// GitHub release files answer 302 and send the bytes from
  /// release-assets.githubusercontent.com as application/octet-stream.
  /// Following that hop inside dart:io can stall on Android, so the next
  /// request is started here instead.
  Future<http.StreamedResponse> _open(
    Uri url,
    Exception Function(String detail) failure,
  ) async {
    var current = url;
    for (var hop = 0; hop < _maxRedirects; hop++) {
      final request = http.Request('GET', current)
        ..followRedirects = false
        ..headers['User-Agent'] = 'Gramnota'
        ..headers['Accept'] = '*/*';
      final response = await _client.send(request);
      if (response.statusCode < 300 || response.statusCode >= 400) {
        return response;
      }
      final location = response.headers['location']?.trim();
      await response.stream.drain<void>();
      if (location == null || location.isEmpty) {
        throw failure('HTTP ${response.statusCode} without a location');
      }
      current = current.resolve(location);
    }
    throw failure('Too many redirects');
  }

  Future<T> _send<T>(
    Future<T> Function() action, {
    Duration timeout = const Duration(minutes: 10),
  }) async {
    try {
      return await action().timeout(timeout);
    } on UpdateManifestException {
      rethrow;
    } on UpdateDownloadException {
      rethrow;
    } on UpdateChecksumException {
      rethrow;
    } on UpdateNetworkException {
      rethrow;
    } on TimeoutException {
      throw const UpdateNetworkException('Timed out');
    } on Object catch (error) {
      throw UpdateNetworkException('$error');
    }
  }
}

/// Named so the call site does not clash with the [sha256] parameter.
final sha256Hash = sha256;

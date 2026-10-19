import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import '../domain/update_check.dart';
import '../domain/update_failures.dart';
import '../domain/update_models.dart';

class UpdateClient implements ManifestSource {
  UpdateClient({http.Client? client, required this.manifestUrl})
    : _client = client ?? http.Client();

  final String manifestUrl;
  final http.Client _client;

  @override
  Future<UpdateManifest> fetchManifest() async {
    final response = await _send(() => _client.get(Uri.parse(manifestUrl)));
    if (response.statusCode != 200) {
      throw const UpdateManifestException();
    }
    try {
      return parseUpdateManifest(response.body);
    } on FormatException {
      throw const UpdateManifestException();
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
      () => _client.send(http.Request('GET', Uri.parse(url))),
    );
    if (response.statusCode != 200) {
      throw const UpdateDownloadException();
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
    } on Object {
      await sink.close();
      if (partial.existsSync()) {
        await partial.delete();
      }
      throw const UpdateDownloadException();
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

  Future<T> _send<T>(Future<T> Function() action) async {
    try {
      return await action().timeout(const Duration(minutes: 10));
    } on TimeoutException {
      throw const UpdateNetworkException();
    } on SocketException {
      throw const UpdateNetworkException();
    } on http.ClientException {
      throw const UpdateNetworkException();
    }
  }
}

/// Named so the call site does not clash with the [sha256] parameter.
final sha256Hash = sha256;

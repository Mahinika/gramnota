import 'dart:io';
import 'dart:typed_data';

import 'byte_source.dart';

/// Inflates a raw DEFLATE stream (ZIP method 8) and keeps only the edges.
Future<EdgeBytes> inflateRawEdges({
  required Stream<List<int>> compressed,
  required int headBytes,
  required int tailBytes,
}) async {
  final sink = _EdgeSink(headBytes, tailBytes);
  final inflater = ZLibDecoder(raw: true).startChunkedConversion(sink);
  await for (final chunk in compressed) {
    inflater.add(chunk);
  }
  inflater.close();
  return EdgeBytes(sink.headBytes, sink.tailBytes);
}

class _EdgeSink implements Sink<List<int>> {
  _EdgeSink(this.headLimit, this.tailLimit);

  final int headLimit;
  final int tailLimit;
  final BytesBuilder _head = BytesBuilder(copy: false);
  final List<Uint8List> _tail = [];
  var _tailLength = 0;

  @override
  void add(List<int> data) {
    if (data.isEmpty) {
      return;
    }
    final bytes = data is Uint8List ? data : Uint8List.fromList(data);
    if (_head.length < headLimit) {
      final need = headLimit - _head.length;
      final take = need < bytes.length ? need : bytes.length;
      _head.add(Uint8List.sublistView(bytes, 0, take));
    }
    if (tailLimit <= 0) {
      return;
    }
    _tail.add(bytes);
    _tailLength += bytes.length;
    while (_tail.length > 1 && _tailLength - _tail.first.length >= tailLimit) {
      _tailLength -= _tail.removeAt(0).length;
    }
  }

  @override
  void close() {}

  Uint8List get headBytes => _head.toBytes();

  Uint8List get tailBytes {
    if (_tailLength == 0) {
      return Uint8List(0);
    }
    if (_tailLength <= tailLimit) {
      final builder = BytesBuilder(copy: false);
      for (final chunk in _tail) {
        builder.add(chunk);
      }
      return builder.toBytes();
    }
    final builder = BytesBuilder(copy: false);
    var skip = _tailLength - tailLimit;
    for (final chunk in _tail) {
      if (skip >= chunk.length) {
        skip -= chunk.length;
        continue;
      }
      builder.add(Uint8List.sublistView(chunk, skip));
      skip = 0;
    }
    return builder.toBytes();
  }
}

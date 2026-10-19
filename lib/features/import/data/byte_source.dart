import 'dart:typed_data';

/// Random-access bytes. Callers read the ranges they need and skip the rest.
abstract class ByteSource {
  int get length;

  Future<Uint8List> read(int start, int end);
}

class MemoryBytes implements ByteSource {
  MemoryBytes(this.bytes);

  final Uint8List bytes;

  @override
  int get length => bytes.length;

  @override
  Future<Uint8List> read(int start, int end) async {
    final from = start.clamp(0, bytes.length);
    final to = end.clamp(from, bytes.length);
    return Uint8List.sublistView(bytes, from, to);
  }
}

class WindowBytes implements ByteSource {
  WindowBytes(this.origin, this.start, this.length);

  final ByteSource origin;
  final int start;

  @override
  final int length;

  @override
  Future<Uint8List> read(int from, int end) {
    final localFrom = from.clamp(0, length);
    final localTo = end.clamp(localFrom, length);
    return origin.read(start + localFrom, start + localTo);
  }
}

class EdgeBytes {
  const EdgeBytes(this.head, this.tail);

  final Uint8List head;
  final Uint8List tail;
}

Future<EdgeBytes> readByteEdges(
  ByteSource source, {
  required int headBytes,
  required int tailBytes,
}) async {
  if (source.length <= 0) {
    return EdgeBytes(Uint8List(0), Uint8List(0));
  }
  final headEnd = headBytes < source.length ? headBytes : source.length;
  final head = await source.read(0, headEnd);
  if (source.length <= headBytes || tailBytes <= 0) {
    return EdgeBytes(head, Uint8List(0));
  }
  final tailStart = source.length - tailBytes;
  final start = tailStart > headEnd ? tailStart : headEnd;
  if (start >= source.length) {
    return EdgeBytes(head, Uint8List(0));
  }
  final tail = await source.read(start, source.length);
  return EdgeBytes(head, tail);
}

EdgeBytes edgesFromList(
  List<int> bytes, {
  required int headBytes,
  required int tailBytes,
}) {
  final data = bytes is Uint8List ? bytes : Uint8List.fromList(bytes);
  if (data.length <= headBytes) {
    return EdgeBytes(data, Uint8List(0));
  }
  final head = Uint8List.sublistView(data, 0, headBytes);
  final tailStart = data.length - tailBytes;
  final start = tailStart > headBytes ? tailStart : headBytes;
  final tail = Uint8List.sublistView(data, start, data.length);
  return EdgeBytes(head, tail);
}

Stream<Uint8List> readChunked(
  ByteSource source,
  int start,
  int length, {
  int chunkSize = 64 * 1024,
}) async* {
  var offset = 0;
  while (offset < length) {
    final size = length - offset < chunkSize ? length - offset : chunkSize;
    yield await source.read(start + offset, start + offset + size);
    offset += size;
  }
}

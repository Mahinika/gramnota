import 'dart:typed_data';

import 'package:archive/archive.dart';

import 'byte_source.dart';

/// Browser builds already hold the picked file. Inflate it, then keep the edges.
Future<EdgeBytes> inflateRawEdges({
  required Stream<List<int>> compressed,
  required int headBytes,
  required int tailBytes,
}) async {
  final compressedBytes = BytesBuilder(copy: false);
  await for (final chunk in compressed) {
    compressedBytes.add(chunk);
  }
  final output = Inflate(compressedBytes.takeBytes()).getBytes();
  return edgesFromList(output, headBytes: headBytes, tailBytes: tailBytes);
}

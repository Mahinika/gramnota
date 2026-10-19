import 'dart:io';
import 'dart:typed_data';

import '../domain/gcode_metadata.dart';
import 'byte_source.dart';
import 'gcode_importer.dart';

Future<GcodeImport> importGcodePath(
  String path, {
  required String displayName,
}) async {
  final length = await File(path).length();
  return importSlice(_PathBytes(path, length), displayName: displayName);
}

/// Reads one range with a stream so the header and footer never share a
/// file handle.
class _PathBytes implements ByteSource {
  _PathBytes(this.path, this.length);

  final String path;

  @override
  final int length;

  @override
  Future<Uint8List> read(int start, int end) async {
    final from = start.clamp(0, length);
    final to = end.clamp(from, length);
    if (from == to) {
      return Uint8List(0);
    }
    final builder = BytesBuilder(copy: false);
    await for (final chunk in File(path).openRead(from, to)) {
      builder.add(chunk);
    }
    return builder.toBytes();
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'byte_source.dart';
import 'inflate_raw.dart';

class ZipMember {
  const ZipMember({
    required this.name,
    required this.method,
    required this.compressedSize,
    required this.uncompressedSize,
    required this.localHeaderOffset,
  });

  final String name;
  final int method;
  final int compressedSize;
  final int uncompressedSize;
  final int localHeaderOffset;
}

Future<List<ZipMember>> readZipMembers(ByteSource source) async {
  if (source.length < 22) {
    throw const FormatException('Not a 3MF archive.');
  }
  final tailSize = source.length < 65557 ? source.length : 65557;
  final tail = await source.read(source.length - tailSize, source.length);
  var eocd = -1;
  for (var i = tail.length - 22; i >= 0; i--) {
    if (tail[i] == 0x50 &&
        tail[i + 1] == 0x4b &&
        tail[i + 2] == 0x05 &&
        tail[i + 3] == 0x06) {
      eocd = i;
      break;
    }
  }
  if (eocd < 0) {
    throw const FormatException('Not a 3MF archive.');
  }
  final entryCount = _u16(tail, eocd + 10);
  final directorySize = _u32(tail, eocd + 12);
  final directoryOffset = _u32(tail, eocd + 16);
  if (directoryOffset == 0xFFFFFFFF || directorySize == 0xFFFFFFFF) {
    throw const FormatException(
      'This 3MF uses Zip64, which Gramnota cannot read.',
    );
  }
  final directoryEnd = directoryOffset + directorySize;
  if (directoryEnd > source.length) {
    throw const FormatException('The 3MF archive is incomplete.');
  }
  final directory = await source.read(directoryOffset, directoryEnd);
  final members = <ZipMember>[];
  var pos = 0;
  for (var index = 0; index < entryCount; index++) {
    if (pos + 46 > directory.length || _u32(directory, pos) != 0x02014b50) {
      break;
    }
    final method = _u16(directory, pos + 10);
    final compressed = _u32(directory, pos + 20);
    final uncompressed = _u32(directory, pos + 24);
    final nameLength = _u16(directory, pos + 28);
    final extraLength = _u16(directory, pos + 30);
    final commentLength = _u16(directory, pos + 32);
    final localOffset = _u32(directory, pos + 42);
    final nameStart = pos + 46;
    final nameEnd = nameStart + nameLength;
    if (nameEnd > directory.length) {
      break;
    }
    final name = utf8.decode(
      directory.sublist(nameStart, nameEnd),
      allowMalformed: true,
    );
    members.add(
      ZipMember(
        name: name,
        method: method,
        compressedSize: compressed,
        uncompressedSize: uncompressed,
        localHeaderOffset: localOffset,
      ),
    );
    pos = nameEnd + extraLength + commentLength;
  }
  return members;
}

Future<EdgeBytes> readMemberEdges(
  ByteSource source,
  ZipMember member, {
  required int headBytes,
  required int tailBytes,
}) async {
  final dataStart = await _dataOffset(source, member);
  if (member.method == 0) {
    final window = WindowBytes(source, dataStart, member.compressedSize);
    return readByteEdges(window, headBytes: headBytes, tailBytes: tailBytes);
  }
  if (member.method == 8) {
    return inflateRawEdges(
      compressed: readChunked(source, dataStart, member.compressedSize),
      headBytes: headBytes,
      tailBytes: tailBytes,
    );
  }
  throw FormatException(
    'Unsupported compression in ${member.name} (method ${member.method}).',
  );
}

Future<Uint8List> readMemberBytes(ByteSource source, ZipMember member) async {
  final cap = member.uncompressedSize <= 0
      ? 2 * 1024 * 1024
      : member.uncompressedSize;
  final edges = await readMemberEdges(
    source,
    member,
    headBytes: cap,
    tailBytes: 0,
  );
  return edges.head;
}

Future<int> _dataOffset(ByteSource source, ZipMember member) async {
  final header = await source.read(
    member.localHeaderOffset,
    member.localHeaderOffset + 30,
  );
  if (header.length < 30 || _u32(header, 0) != 0x04034b50) {
    throw const FormatException('The 3MF archive is missing a file header.');
  }
  final nameLength = _u16(header, 26);
  final extraLength = _u16(header, 28);
  return member.localHeaderOffset + 30 + nameLength + extraLength;
}

int _u16(Uint8List bytes, int offset) {
  return bytes[offset] | (bytes[offset + 1] << 8);
}

int _u32(Uint8List bytes, int offset) {
  return bytes[offset] |
      (bytes[offset + 1] << 8) |
      (bytes[offset + 2] << 16) |
      (bytes[offset + 3] << 24);
}

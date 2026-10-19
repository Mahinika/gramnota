import '../domain/gcode_metadata.dart';

Future<GcodeImport> importGcodePath(
  String path, {
  required String displayName,
}) async {
  throw UnsupportedError(
    'This browser build reads the file you pick, not a disk path.',
  );
}

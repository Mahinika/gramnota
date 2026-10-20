import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// Shares the workshop JSON. On Windows the seller also picks a file path.
Future<void> deliverWorkshopBackup(String jsonText) async {
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/gramnota-workshop.json');
  await file.writeAsString(jsonText, flush: true);
  if (Platform.isWindows) {
    await FilePicker.saveFile(
      fileName: 'gramnota-workshop.json',
      bytes: utf8.encode(jsonText),
      mimeType: 'application/json',
      type: FileType.custom,
      allowedExtensions: const ['json'],
    );
  }
  await SharePlus.instance.share(
    ShareParams(
      files: [
        XFile(
          file.path,
          mimeType: 'application/json',
          name: 'gramnota-workshop.json',
        ),
      ],
    ),
  );
}

/// Reads a JSON file the seller picked. Null when the dialog is cancelled.
Future<String?> readPickedWorkshopBackup() async {
  final picked = await FilePicker.pickFiles(
    type: FileType.custom,
    allowedExtensions: const ['json'],
  );
  if (picked.isEmpty) {
    return null;
  }
  final bytes = await picked.single.readAsBytes();
  return utf8.decode(bytes);
}

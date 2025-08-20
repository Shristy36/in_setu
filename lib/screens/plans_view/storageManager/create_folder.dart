
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:in_setu/screens/plans_view/storageManager/model/folder_model.dart';
import 'package:path_provider/path_provider.dart';

Future<void> createFolderAndFilesExternal(
    String siteName,
    String mainFolder,
    String newSubFolderName,
    List<PlatformFile> files,
    ) async {
  final appDir = await getExternalStorageDirectory();
  if (appDir == null) return;

  final basePath = "${appDir.path}/$siteName";
  FolderModel folderModel = FolderModel();

  for (final folder in folderModel.subFolders) {
    final dir = Directory("$basePath/$folder");
    if (!await dir.exists()) {
      await dir.create(recursive: true);
      print("Folder created: ${dir.path}");
    }
  }

  final targetMainFolderDir = Directory("$basePath/$mainFolder");
  final subDir = Directory("${targetMainFolderDir.path}/$newSubFolderName");

  if (!await subDir.exists()) {
    await subDir.create(recursive: true);
    print("Subfolder created: ${subDir.path}");
  }

  for (final file in files) {
    if (file.path == null) continue;

    final targetFile = File("${subDir.path}/${file.name}");
    try {
      await File(file.path!).copy(targetFile.path);
      print("Copied ${file.name} to ${targetFile.path}");
    } catch (e) {
      print("Error copying file ${file.name}: $e");
    }
  }
}



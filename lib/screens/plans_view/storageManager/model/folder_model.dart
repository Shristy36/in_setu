class FolderModel {
  List<String> subFolders;
  List<String> allowedFileTypes;

  FolderModel({
    List<String>? initialFolders,
    List<String>? initialFileTypes,
  })  : subFolders = initialFolders ?? ["Architectural", "Structural", "MEP"],
        allowedFileTypes = initialFileTypes ?? [
          'image/jpeg',
          'image/jpg',
          'image/png',
          'application/pdf',
          'application/dwg',
        ];

  void addFolder(String folderName) {
    if (folderName.trim().isNotEmpty && !subFolders.contains(folderName)) {
      subFolders.add(folderName);
    }
  }

  void removeFolder(String folderName) {
    subFolders.remove(folderName);
  }

  void addFileType(String fileType) {
    if (fileType.trim().isNotEmpty && !allowedFileTypes.contains(fileType)) {
      allowedFileTypes.add(fileType);
    }
  }

  void removeFileType(String fileType) {
    allowedFileTypes.remove(fileType);
  }

  Map<String, dynamic> toJson() => {
    'subFolders': subFolders,
    'allowedFileTypes': allowedFileTypes,
  };

  factory FolderModel.fromJson(Map<String, dynamic> json) {
    return FolderModel(
      initialFolders: List<String>.from(json['subFolders']),
      initialFileTypes: List<String>.from(json['allowedFileTypes']),
    );
  }
}


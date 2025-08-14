part of 'plans_bloc.dart';


abstract class PlansEvent{
  PlansEvent();
}

class DocumentLevelOneFetch extends PlansEvent{
  dynamic siteId;
  String folderName;
  dynamic levelNo;

  DocumentLevelOneFetch({required this.siteId, required this.folderName, required this.levelNo});

}
class DocumentLevelSecFetch extends PlansEvent{
  dynamic siteId;
  String folderName;
  dynamic levelNo;

  DocumentLevelSecFetch({required this.siteId, required this.folderName, required this.levelNo});

}
class CreateLevelOneFileFetch extends PlansEvent{
  dynamic levelId;
  String isWhatCreating;
  String folderName;
  dynamic siteId;
  dynamic filePath;
  CreateLevelOneFileFetch({required this.levelId, required this.isWhatCreating, required this.folderName, required this.siteId, required this.filePath});
}

class CreateLevelSecondFileFetch extends PlansEvent{
  dynamic comingFromLevel;
  String isWhatCreating;
  String folderName;
  dynamic dirId;
  String currentFolderName;
  dynamic siteId;
  dynamic filePath;
  CreateLevelSecondFileFetch({required this.comingFromLevel, required this.isWhatCreating, required this.folderName, required this.dirId, required this.currentFolderName, required this.siteId, required this.filePath});
}

class CreateLevelThirdFileFetch extends PlansEvent{
  dynamic comingFromLevel;
  String isWhatCreating;
  String folderName;
  dynamic dirId;
  String currentFolderName;
  dynamic siteId;
  dynamic filePath;
  CreateLevelThirdFileFetch({required this.comingFromLevel, required this.isWhatCreating, required this.folderName, required this.dirId, required this.currentFolderName, required this.siteId, required this.filePath});
}

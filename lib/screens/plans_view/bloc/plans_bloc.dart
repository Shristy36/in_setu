import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/plans_view/model/DocumentLevelOneResponse.dart';
import 'package:in_setu/screens/plans_view/model/FileCreateResponse.dart';
import 'package:in_setu/screens/plans_view/plan_repo/plans_repo.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;

part 'plans_event.dart';

part 'plans_state.dart';

class PlansBloc extends Bloc<PlansEvent, GlobalApiResponseState> {
  PlansRepository plansRepository;

  PlansBloc({required this.plansRepository}) : super(const InitialState()) {
    on<DocumentLevelOneFetch>(onLevelOne);
    on<CreateLevelOneFileFetch>(onCreateFileLevelOne);
    on<DocumentLevelSecFetch>(onLevelSec);
    on<CreateLevelSecondFileFetch>(onCreateFileLevelSecond);
    on<CreateLevelThirdFileFetch>(onCreateFileLevelThird);
  }

  onLevelOne(PlansEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is DocumentLevelOneFetch) {
      emitter(const ApiLoadingState());
      final paramsArg = {
        'site_id': event.siteId,
        'current_folder_name': event.folderName,
        'level_no': event.levelNo,
      };
      try {
        ApiResult<DocumentLevelOneResponse> levelOneFetch =
            await plansRepository.getLevelOneDocument(paramsArg);
        levelOneFetch.when(
          success:
              (DocumentLevelOneResponse levelOneResponse) =>
                  emitter(LevelOneDocumentStateSuccess(data: levelOneResponse)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }
  onLevelSec(PlansEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is DocumentLevelSecFetch) {
      emitter(const ApiLoadingState());
      final paramsArg = {
        'site_id': event.siteId,
        'current_folder_name': event.folderName,
        'level_no': event.levelNo,
      };
      try {
        ApiResult<DocumentLevelOneResponse> secLevelFilesFetch =
            await plansRepository.getLevelSecDocument(paramsArg);
        secLevelFilesFetch.when(
          success:
              (DocumentLevelOneResponse levelSecResponse) =>
                  emitter(LevelSecDocumentStateSuccess(data: levelSecResponse)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }

  onCreateFileLevelOne(PlansEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is CreateLevelOneFileFetch) {
      emitter(const ApiLoadingState());

      Future<FormData> buildFormData({String? filePath}) async {
        final Map<String, dynamic> formMap = {
          'level_id': event.levelId,
          'is_what_creating': event.isWhatCreating,
          'folder_name': event.folderName,
          'site_id': event.siteId,
        };

        if (filePath != null && filePath.isNotEmpty) {
          formMap['file'] = await MultipartFile.fromFile(
            filePath,
            filename: p.basename(filePath),
            contentType: _getMediaType(filePath),
          );
        }

        return FormData.fromMap(formMap);
      }

      final formData = await buildFormData(filePath: event.filePath);

      try {
        ApiResult<FileCreateResponse> levelOneFetch =
        await plansRepository.createFileResponse(formData);
        levelOneFetch.when(
          success: (FileCreateResponse levelOneResponse) =>
              emitter(LevelOneCreateFileStateSuccess(data: levelOneResponse)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }

  onCreateFileLevelSecond(PlansEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is CreateLevelSecondFileFetch) {
      emitter(const ApiLoadingState());

      Future<FormData> buildFormData({String? filePath}) async {
        final Map<String, dynamic> formMap = {
          'coming_from_level': event.comingFromLevel,
          'is_what_creating': event.isWhatCreating,
          'folder_name': event.folderName,
          'dir_id': event.dirId,
          'current_folder_name': event.currentFolderName,
          'site_id': event.siteId,
        };

        if (filePath != null && filePath.isNotEmpty) {
          formMap['file'] = await MultipartFile.fromFile(
            filePath,
            filename: p.basename(filePath),
            contentType: _getMediaType(filePath),
          );
        }

        return FormData.fromMap(formMap);
      }

      final formData = await buildFormData(filePath: event.filePath);

      try {
        ApiResult<FileCreateResponse> createLevelSecFetch =
        await plansRepository.createSecondLevelFileResponse(formData);
        createLevelSecFetch.when(
          success: (FileCreateResponse createSecondResponse) =>
              emitter(LevelSecondCreateFileStateSuccess(data: createSecondResponse)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }
  onCreateFileLevelThird(PlansEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is CreateLevelThirdFileFetch) {
      emitter(const ApiLoadingState());

      Future<FormData> buildFormData({String? filePath}) async {
        final Map<String, dynamic> formMap = {
          'coming_from_level': event.comingFromLevel,
          'is_what_creating': event.isWhatCreating,
          'folder_name': event.folderName,
          'dir_id': event.dirId,
          'current_folder_name': event.currentFolderName,
          'site_id': event.siteId,
        };

        if (filePath != null && filePath.isNotEmpty) {
          formMap['file'] = await MultipartFile.fromFile(
            filePath,
            filename: p.basename(filePath),
            contentType: _getMediaType(filePath),
          );
        }

        return FormData.fromMap(formMap);
      }

      final formData = await buildFormData(filePath: event.filePath);

      try {
        ApiResult<FileCreateResponse> createLevelThirdFetch =
        await plansRepository.createThirdLevelFileResponse(formData);
        createLevelThirdFetch.when(
          success: (FileCreateResponse createThirdResponse) =>
              emitter(LevelThirdCreateFileStateSuccess(data: createThirdResponse)),
          failure: (AppException ex) async {
            emitter(ApiErrorState(exception: ex));
          },
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }

  MediaType _getMediaType(String path) {
    final ext = p.extension(path).toLowerCase();
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return MediaType('image', 'jpeg');
      case '.png':
        return MediaType('image', 'png');
      case '.pdf':
        return MediaType('application', 'pdf');
      case '.dwg':
        return MediaType('application', 'dwg');
      default:
        throw UnsupportedError('File type not allowed');
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/mainpower_screen/mainpower_repo/main_power_repository.dart';
import 'package:in_setu/screens/mainpower_screen/model/CreateManPowerResponse.dart';
import 'package:in_setu/screens/mainpower_screen/model/DeleteManPowerResponse.dart';
import 'package:in_setu/screens/mainpower_screen/model/ManPowerModelResponse.dart';
import 'package:in_setu/supports/AppException.dart';

part 'man_power_event.dart';
part 'man_power_state.dart';

class ManPowerBloc extends Bloc<ManPowerEvet, GlobalApiResponseState> {
  final ManPowerRepository manPowerRepository;

  ManPowerBloc({required this.manPowerRepository}) : super(const InitialState()) {
    on<ManPowerItemFetch>(onMainPowerItemFetch);
    on<CreateManPowerItemFetch>(createManPowerItem);
    on<DeleteManPowerItemFetch>(deleteManPowerItem);
    on<UpdateManPowerItemFetch>(updateManPowerItem);
    on<ManPowerFetchByDate>(onManPowerFetchByDate);
  }

  onMainPowerItemFetch(ManPowerEvet event, Emitter<GlobalApiResponseState> emit) async {
    if (event is ManPowerItemFetch) {
      emit(const ApiLoadingState());
      final params = {
        "site_id": event.siteId,
        "current_date": event.currentDate,
      };
      try {
        final mainPowerResponse = await manPowerRepository.getManPowerItems(
            params);
        mainPowerResponse.when(
          success: (data) => emit(ManPowerStateSuccess(data: data)),
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emit(ApiErrorState(exception: e));
      }
    }
  }

  onManPowerFetchByDate(ManPowerEvet event, Emitter<GlobalApiResponseState> emit) async {
    if (event is ManPowerFetchByDate) {
      emit(const ApiLoadingState());
      final params = {
        "site_id": event.siteId,
        "current_date": event.selectedDate,
      };
      try {
        final response = await manPowerRepository.getManPowerItems(params);
        response.when(
          success: (data) => emit(ManPowerDateStateSuccess(data: data)),
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emit(ApiErrorState(exception: e));
      }
    }
  }

  createManPowerItem(ManPowerEvet event, Emitter<GlobalApiResponseState> emit) async {
    if(event is CreateManPowerItemFetch) {
      emit(const ApiLoadingState());
      final Map<String, dynamic> body = {
        "site_id": event.siteId,
        "agency_name": event.agencyName,
        "staffs": event.staffs,
        "manpowers": event.manPowers,
        "tasks": event.tasks,
      };
      try {
        final createManPowerResponse = await manPowerRepository.createManPowerItem(body);
        createManPowerResponse.when(
          success: (CreateManPowerResponse createManPowerResponse) => emit(CreateManPowerStateSuccess(data: createManPowerResponse)),
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emit(ApiErrorState(exception: e));
      }
    }
  }

  deleteManPowerItem(
      ManPowerEvet event,
      Emitter<GlobalApiResponseState> emitter,
      ) async {
    if (event is DeleteManPowerItemFetch) {
      emitter(const ApiLoadingState());
      try {
        ApiResult<DeleteManPowerResponse> sitesResponse = await manPowerRepository
            .deleteManPowerItemResponse(event.id);
        sitesResponse.when(
          success:
              (DeleteManPowerResponse manPowerDeleteResponse) =>
              emitter(DeleteManPowerStateSuccess(data: manPowerDeleteResponse)),
          failure: (AppException ex) => emitter(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }
  updateManPowerItem(ManPowerEvet event, Emitter<GlobalApiResponseState> emit) async {
    if(event is UpdateManPowerItemFetch) {
      emit(const ApiLoadingState());
      final Map<String, dynamic> updateBody = {
        "site_id": event.siteId,
        "agency_name": event.agencyName,
        "staffs": event.staffs,
        "manpowers": event.manPowers,
        "tasks": event.tasks,
      };
      try{
        final updateManPowerResponse = await manPowerRepository.updateManPowerItem(event.id, updateBody);
        updateManPowerResponse.when(
          success: (CreateManPowerResponse createManPowerResponse) => emit(CreateManPowerStateSuccess(data: createManPowerResponse)),
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      }on AppException catch(e){
        emit(ApiErrorState(exception: e));
      }
    }
  }
}

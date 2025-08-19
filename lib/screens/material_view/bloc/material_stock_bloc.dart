import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/material_view/material_repo/material_repository.dart';
import 'package:in_setu/screens/material_view/model/CreateStockMaterialResponse.dart';
import 'package:in_setu/screens/material_view/model/DeleteIntentReponse.dart';
import 'package:in_setu/screens/material_view/model/MaterialSearchKeyword.dart';
import 'package:in_setu/screens/material_view/model/MaterialStockReponse.dart';
import 'package:in_setu/screens/material_view/model/SearchUnitResponse.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/supports/share_preference_manager.dart';
import 'package:meta/meta.dart';

part 'material_stock_event.dart';

part 'material_stock_state.dart';

class MaterialStockBloc
    extends Bloc<MaterialStockEvent, GlobalApiResponseState> {
  MaterialRepository materialRepository = MaterialRepository();

  MaterialStockBloc({required this.materialRepository})
    : super(const InitialState()) {
    on<MaterialStockFetchEvent>(onMaterialStockFetch);
    on<DeleteIntentEvent>(onDeleteIntent);
    on<DeleteStockEvent>(onDeleteStock);
    on<CreateStockEvent>(onCreateStock);
    on<UpdateStockEvent>(onUpdateStock);
    on<SearchKeywordEvent>(onSearchKeyword);
    on<SearchUnitEvent>(onSearchUnitKeyword);
  }

  onDeleteIntent(
    MaterialStockEvent event,
    Emitter<GlobalApiResponseState> emit,
  ) async {
    if (event is DeleteIntentEvent) {
      emit(const ApiLoadingState());
      try {
        ApiResult<DeleteIntentReponse> deleteResponse = await materialRepository
            .deleteIntentResponse(event.id);
        deleteResponse.when(
          success:
              (DeleteIntentReponse updateResponse) =>
                  emit(DeleteIntentStateSuccess(data: updateResponse)),
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emit(ApiErrorState(exception: e));
      }
    }
  }

  onDeleteStock(
    MaterialStockEvent event,
    Emitter<GlobalApiResponseState> emit,
  ) async {
    if (event is DeleteStockEvent) {
      emit(const ApiLoadingState());
      try {
        ApiResult<DeleteIntentReponse> deleteResponse = await materialRepository
            .deleteStockResponse(event.id);
        deleteResponse.when(
          success:
              (DeleteIntentReponse updateResponse) =>
                  emit(DeleteIntentStateSuccess(data: updateResponse)),
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emit(ApiErrorState(exception: e));
      }
    }
  }

  onMaterialStockFetch(
    MaterialStockEvent event,
    Emitter<GlobalApiResponseState> emit,
  ) async {
    if (event is MaterialStockFetchEvent) {
      emit(const ApiLoadingState());
      final params = {"site_id": event.siteId};
      try {
        ApiResult<MaterialStockReponse> stockResponse = await materialRepository
            .getMaterialStockDetails(params);
        stockResponse.when(
          success:
              (MaterialStockReponse updateResponse) =>
                  emit(MaterialStockStateSuccess(data: updateResponse)),
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emit(ApiErrorState(exception: e));
      }
    }
  }

  onCreateStock(
    MaterialStockEvent event,
    Emitter<GlobalApiResponseState> emit,
  ) async {
    if (event is CreateStockEvent) {
      emit(const ApiLoadingState());
      final bodyParams = {
        "site_id": event.siteId,
        "requirement_1": event.requirement,
        "requirement_2": event.additionalRequirement,
        "requirement_2_data": {
          "id": 602,
          "name": event.additionalRequirement,
          "defaultUoMId": 1,
          "defaultUomName": "BAG",
          "value": "51",
          "categoryId": 3,
          "categoryName": "Civil Work Materials",
          "created_at": event.createDate,
        },
        "unit": event.unit,
        "unit_data": {
          "id": 15,
          "name": event.unit,
          "created_at": event.createDate,
        },
        "qty": event.quantity,
      };
      try {
        ApiResult<CreateStockMaterialResponse> stockResponse =
            await materialRepository.createStockMaterial(bodyParams);
        stockResponse.when(
          success:
              (CreateStockMaterialResponse updateResponse) =>
                  emit(CreateStockStateSuccess(data: updateResponse)),
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emit(ApiErrorState(exception: e));
      }
    }
  }

  onUpdateStock(
    MaterialStockEvent event,
    Emitter<GlobalApiResponseState> emit,
  ) async {
    if (event is UpdateStockEvent) {
      emit(const ApiLoadingState());
      final bodyParams = {
        "site_id": event.siteId,
        "requirement_1": event.requirement,
        "requirement_2": event.additionalRequirement,
        "requirement_2_data": {
          "id": 602,
          "name": event.additionalRequirement,
          "defaultUoMId": 1,
          "defaultUomName": "BAG",
          "value": "51",
          "categoryId": 3,
          "categoryName": "Civil Work Materials",
          "created_at": event.createDate,
        },
        "unit": event.unit,
        "unit_data": {
          "id": 15,
          "name": event.unit,
          "created_at": event.createDate,
        },
        "qty": event.quantity,
      };
      try {
        ApiResult<CreateStockMaterialResponse> stockResponse =
            await materialRepository.updateStockMaterial(event.id, bodyParams);
        stockResponse.when(
          success:
              (CreateStockMaterialResponse updateResponse) =>
                  emit(CreateStockStateSuccess(data: updateResponse)),
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emit(ApiErrorState(exception: e));
      }
    }
  }

  onSearchKeyword(
    MaterialStockEvent event,
    Emitter<GlobalApiResponseState> emit,
  ) async {
    if (event is SearchKeywordEvent) {
      emit(const ApiLoadingState());
      final params = {
        "search_text": event.searchText,
        "request_type": event.requestType,
      };
      try {
        ApiResult<MaterialSearchKeyword> stockResponse =
            await materialRepository.getMaterialSearchKeyword(params);
        stockResponse.when(
          success: (MaterialSearchKeyword searchKeyword) {
            SharedPreferenceManager.saveSearchDataList(searchKeyword.data);
            emit(MaterialSearchKeywordStateSuccess(data: searchKeyword));
          },
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emit(ApiErrorState(exception: e));
      }
    }
  }

  onSearchUnitKeyword(
    MaterialStockEvent event,
    Emitter<GlobalApiResponseState> emit,
  ) async {
    if (event is SearchUnitEvent) {
      emit(const ApiLoadingState());
      final params = {
        "search_text": event.searchText,
        "request_type": event.requestType,
      };
      try {
        ApiResult<SearchUnitResponse> stockResponse = await materialRepository
            .getSearchUnit(params);
        stockResponse.when(
          success: (SearchUnitResponse searchUnitResponse) {
            SharedPreferenceManager.saveSearchUnitDataList(searchUnitResponse.data);
            emit(SearchUnitStateSuccess(data: searchUnitResponse));
          },
          failure: (AppException ex) => emit(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emit(ApiErrorState(exception: e));
      }
    }
  }
}

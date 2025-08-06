import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/cash_details_view/cash_repo/cash_book_repository.dart';
import 'package:in_setu/screens/cash_details_view/model/CashBookDeleteResponse.dart';
import 'package:in_setu/screens/cash_details_view/model/CashbookCreateResponse.dart';
import 'package:in_setu/screens/cash_details_view/model/CashbookDetailResponse.dart';
import 'package:in_setu/screens/cash_details_view/model/SetDefaultResponse.dart';
import 'package:in_setu/supports/AppException.dart';


part 'cashbook_event.dart';
part 'cashbook_state.dart';

class CashbookBloc extends Bloc<CashbookEvent, GlobalApiResponseState> {
  CashbookRepository cashbookRepository = CashbookRepository();

  CashbookBloc({required this.cashbookRepository}) : super(const InitialState()) {
    on<CashbookFetchEvent>(getCashbookDetails);
    on<CashBookCreateEvent>(onCreateCashBook);
    on<DeleteCashBookEvent>(onDeleteCashBook);
    on<UpdateCashBookEvent>(onUpdateCashBook);
    on<SetDefaultCashBookEvent>(onSetDefaultCashBook);
    on<AddTransactionCashBookEvent>(onAddTransactionCashBook);
  }
  getCashbookDetails(CashbookEvent event, Emitter<GlobalApiResponseState> emit) async {
     if(event is CashbookFetchEvent){
       emit(const ApiLoadingState());
       final params = {
         "site_id" : event.siteId
       };
       try{
         ApiResult<CashbookDetailResponse> cashbookDetailResponse = await cashbookRepository.getCashbookDetails(params);
         cashbookDetailResponse.when(
             success: (CashbookDetailResponse cashbookDetailResponse) => emit(CashbookStateSuccess(data: cashbookDetailResponse)),
             failure: (AppException ex) => emit(ApiErrorState(exception: ex)));
       }on AppException catch(e){
         emit(ApiErrorState(exception: e));
       }
     }
  }
  onCreateCashBook(CashbookEvent event, Emitter<GlobalApiResponseState> emit) async {
    if(event is CashBookCreateEvent){
      emit(const ApiLoadingState());
      final bodyParam = {
        "site_id" : event.siteId,
        "cashbook_name" : event.cashBookName
      };
      try{
        ApiResult<CashbookCreateResponse> createCashBookResp = await cashbookRepository.createCashBook(bodyParam);
        createCashBookResp.when(
            success: (CashbookCreateResponse cashbookCreateResponse) => emit(CashBookCreateStateSuccess(data: cashbookCreateResponse)),
            failure: (AppException ex) => emit(ApiErrorState(exception: ex)));
      }on AppException catch(e){
        emit(ApiErrorState(exception: e));
      }
    }
  }
  onUpdateCashBook(CashbookEvent event, Emitter<GlobalApiResponseState> emit) async {
    if(event is UpdateCashBookEvent){
      emit(const ApiLoadingState());
      final bodyParam = {
        "site_id" : event.siteId,
        "cashbook_name" : event.cashBookName
      };
      try{
        ApiResult<CashbookCreateResponse> updateResponse = await cashbookRepository.updateCashBook(event.cashBookId, bodyParam);
        updateResponse.when(
            success: (CashbookCreateResponse update) => emit(UpdateCashBookStateSuccess(data: update)),
            failure: (AppException ex) => emit(ApiErrorState(exception: ex)));
      }on AppException catch(e){
        emit(ApiErrorState(exception: e));
      }
    }
  }
  onSetDefaultCashBook(CashbookEvent event, Emitter<GlobalApiResponseState> emit) async {
    if(event is SetDefaultCashBookEvent){
      emit(const ApiLoadingState());
      final bodyParam = {
        "id" : event.cashBookId,
        "cashbook_name" : event.cashBookName,
        "user_id" : event.userId,
        "site_id" : event.siteId,
        "is_default" : event.isDefault,
        "clicked" : event.clicked
      };
      try{
        ApiResult<SetDefaultResponse> defaultResponse = await cashbookRepository.setDefaultCashbook(event.cashBookId, bodyParam);
        defaultResponse.when(
            success: (SetDefaultResponse defaultValue) => emit(SetDefaultCashBookStateSuccess(data: defaultValue)),
            failure: (AppException ex) => emit(ApiErrorState(exception: ex)));
      }on AppException catch(e){
        emit(ApiErrorState(exception: e));
      }
    }
  }
  onAddTransactionCashBook(CashbookEvent event, Emitter<GlobalApiResponseState> emit) async {
    if(event is AddTransactionCashBookEvent){
      emit(const ApiLoadingState());
      final bodyParam = {
        "book_id" : event.bookId,
        "site_id" : event.siteId,
        "toggle_value" : event.toggleValue,
        "amount" : event.amount,
        "remark" : event.remark,
        "current_date" : event.currentDate
      };
      try{
        ApiResult<SetDefaultResponse> defaultResponse = await cashbookRepository.addTransactionCashBook(bodyParam);
        defaultResponse.when(
            success: (SetDefaultResponse defaultValue) => emit(AddTransactionCashBookStateSuccess(data: defaultValue)),
            failure: (AppException ex) => emit(ApiErrorState(exception: ex)));
      }on AppException catch(e){
        emit(ApiErrorState(exception: e));
      }
    }
  }
  onDeleteCashBook(CashbookEvent event, Emitter<GlobalApiResponseState> emit) async {
    if(event is DeleteCashBookEvent){
      emit(const ApiLoadingState());
      try{
        ApiResult<CashBookDeleteResponse> deleteCashBookResp = await cashbookRepository.deleteCashBook(event.cashBookId);
        deleteCashBookResp.when(
            success: (CashBookDeleteResponse deleteResponse) => emit(DeleteCashBookStateSuccess(data: deleteResponse)),
            failure: (AppException ex) => emit(ApiErrorState(exception: ex)));
      }on AppException catch(e){
        emit(ApiErrorState(exception: e));
      }
    }
  }
}

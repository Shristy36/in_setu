import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/views/cash_details_view/cash_repo/cash_book_repository.dart';
import 'package:in_setu/views/cash_details_view/model/CashbookDetailResponse.dart';
import 'package:meta/meta.dart';

part 'cashbook_event.dart';
part 'cashbook_state.dart';

class CashbookBloc extends Bloc<CashbookEvent, GlobalApiResponseState> {
  CashbookRepository cashbookRepository = CashbookRepository();

  CashbookBloc({required this.cashbookRepository}) : super(const InitialState()) {
    on<CashbookEvent>(getCashbookDetails);
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
}

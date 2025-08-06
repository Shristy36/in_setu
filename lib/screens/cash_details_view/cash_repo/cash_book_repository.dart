
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/NetworkService.dart';
import 'package:in_setu/screens/cash_details_view/model/CashBookDeleteResponse.dart';
import 'package:in_setu/screens/cash_details_view/model/CashbookCreateResponse.dart';
import 'package:in_setu/screens/cash_details_view/model/CashbookDetailResponse.dart';
import 'package:in_setu/screens/cash_details_view/model/SetDefaultResponse.dart';
import 'package:in_setu/supports/AppException.dart';

class CashbookRepository{
   final NetworkService networkService = NetworkService();

   CashbookRepository();

   Future<ApiResult<CashbookDetailResponse>> getCashbookDetails(dynamic params) async{
     try{
       final cashBookResponse = await networkService.get(ApiConstants.cashBookDetailsEndPoint, params, null);
       return ApiResult.success(data: CashbookDetailResponse.fromJson(cashBookResponse));
     }on AppException catch(e){
       return ApiResult.failure(error: e);
     }
   }

   Future<ApiResult<CashbookCreateResponse>> createCashBook(dynamic bodyParam) async{
     try{
       final createCashBookResponse = await networkService.post(ApiConstants.cashbookCreateEndPoint, null, null, bodyParam);
       return ApiResult.success(data: CashbookCreateResponse.fromJson(createCashBookResponse));
     }on AppException catch(e){
       return ApiResult.failure(error: e);
     }
   }

   Future<ApiResult<CashbookCreateResponse>> updateCashBook(dynamic cashBookId, dynamic bodyParam) async{
     try{
       final createCashBookResponse = await networkService.put("${ApiConstants.updateCashBookEndPoint}/$cashBookId", null, null, bodyParam);
       return ApiResult.success(data: CashbookCreateResponse.fromJson(createCashBookResponse));
     }on AppException catch(e){
       return ApiResult.failure(error: e);
     }
   }

   Future<ApiResult<CashBookDeleteResponse>> deleteCashBook(dynamic cashBookId) async{
     try{
       final deleteResponse = await networkService.delete("${ApiConstants.cashbookDeleteEndPoint}/$cashBookId", null, null, null);
       return ApiResult.success(data: CashBookDeleteResponse.fromJson(deleteResponse));
     }on AppException catch(e){
       return ApiResult.failure(error: e);
     }
   }
   Future<ApiResult<SetDefaultResponse>> setDefaultCashbook(dynamic cashBookId, dynamic bodyPayload) async{
     try {
       final defaultResponse = await networkService.put("${ApiConstants.setDefaultValueBookEndPoint}/$cashBookId", null, null, bodyPayload);
       return ApiResult.success(data: SetDefaultResponse.fromJson(defaultResponse));
     }on AppException catch (e) {
       return ApiResult.failure(error: e);
     }
   }
   Future<ApiResult<SetDefaultResponse>> addTransactionCashBook(dynamic bodyPayload) async{
     try {
       final transactionResponse = await networkService.post(ApiConstants.addTransactionEndPoint, null, null, bodyPayload);
       return ApiResult.success(data: SetDefaultResponse.fromJson(transactionResponse));
     }on AppException catch (e) {
       return ApiResult.failure(error: e);
     }
   }
}
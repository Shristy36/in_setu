
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/NetworkService.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/views/cash_details_view/model/CashbookDetailResponse.dart';

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
}
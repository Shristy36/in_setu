
import 'package:in_setu/networkSupport/ApiConstants.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/NetworkService.dart';
import 'package:in_setu/screens/chat/model/ChatsDetailResponse.dart';
import 'package:in_setu/supports/AppException.dart';

class ChatsRepository{
  final NetworkService networkService = NetworkService();

  ChatsRepository();

  Future<ApiResult<ChatsDetailResponse>> getChatsConversationDetails() async{
    try{
      final chatsResponse = await networkService.get(ApiConstants.chatsConversationEndPoint, null, null);
      return ApiResult.success(data: ChatsDetailResponse.fromJson(chatsResponse));
    }on AppException catch(e){
      return ApiResult.failure(error: e);
    }
  }
}
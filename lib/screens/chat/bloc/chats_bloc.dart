import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/ApiResponseState.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/chat/chats_repo/chats_repo.dart';
import 'package:in_setu/screens/chat/model/ChatsDetailResponse.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:meta/meta.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsDetailEvent, GlobalApiResponseState> {
  final ChatsRepository chatsRepository;
  ChatsBloc({required this.chatsRepository}) : super(const InitialState()) {
    on<ChatsDetailEvent>(GetChatDetails);
  }

  GetChatDetails(ChatsDetailEvent event, Emitter<GlobalApiResponseState> emit) async{
    if(event is FetchChatsDetails) {
      emit(const ApiLoadingState());
      try{
        ApiResult<ChatsDetailResponse> chatsDetailResponse = await chatsRepository.getChatsConversationDetails();
        chatsDetailResponse.when(
          success: (ChatsDetailResponse chatsDetailResponse) => emit(ChatsDetailsStateSuccess(data: chatsDetailResponse)),
          failure: (AppException ex) => emit(ApiErrorState(exception: ex))
        );

      }on AppException catch(e){
        emit(ApiErrorState(exception: e));
      }
    }
  }
}

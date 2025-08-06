part of 'chats_bloc.dart';

class ChatsDetailsStateSuccess<T> extends GlobalApiResponseState<T>{
  ChatsDetailsStateSuccess({
    T? data,
    String message = ''
  }): super(status: GlobalApiStatus.completed, message: message, data: data);
}

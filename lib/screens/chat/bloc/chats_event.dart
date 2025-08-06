part of 'chats_bloc.dart';

abstract class ChatsDetailEvent{
  const ChatsDetailEvent();
}

class FetchChatsDetails extends ChatsDetailEvent{
  const FetchChatsDetails();
}

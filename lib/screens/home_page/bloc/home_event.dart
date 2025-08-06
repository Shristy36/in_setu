part of 'home_bloc.dart';

abstract class HomeEvent{
  const HomeEvent();
}

class GetDashBoardApi extends HomeEvent{
  final dynamic userId;

  GetDashBoardApi(this.userId);
}

class GetSiteMemberEvent extends HomeEvent{
  dynamic siteId;
  GetSiteMemberEvent({required this.siteId});
}

class AddMemberEvent extends HomeEvent{
  Map<String, dynamic> map;
  AddMemberEvent({required this.map});
}

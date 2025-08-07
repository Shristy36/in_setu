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
  final dynamic siteId;
  final List<Map<String, dynamic>> siteMembers;
  AddMemberEvent({required this.siteId, required this.siteMembers});
}
class MakeAdminEvent extends HomeEvent{
  final Map<String, dynamic> reqParams;
  final String reqType;
  final dynamic siteId;

  MakeAdminEvent({
    required this.reqParams,
    required this.reqType,
    required this.siteId,
  });
}
class RemoveSiteMemberEvent extends HomeEvent{
  final Map<String, dynamic> reqParams;
  final String reqType;
  final dynamic siteId;

  RemoveSiteMemberEvent({
    required this.reqParams,
    required this.reqType,
    required this.siteId,
  });
}
class ReInviteEvent extends HomeEvent{
  final Map<String, dynamic> reqParams;
  final String reqType;
  final dynamic siteId;

  ReInviteEvent({
    required this.reqParams,
    required this.reqType,
    required this.siteId,
  });
}

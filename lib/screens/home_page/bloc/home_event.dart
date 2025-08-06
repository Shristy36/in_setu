part of 'home_bloc.dart';

abstract class HomeEvent{
  const HomeEvent();
}

class GetDashBoardApi extends HomeEvent{
  final dynamic userId;

  GetDashBoardApi(this.userId);
}

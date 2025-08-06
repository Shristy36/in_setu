part of 'cashbook_bloc.dart';

abstract class CashbookEvent{
  const CashbookEvent();
}

class CashbookFetchEvent extends CashbookEvent{
  final dynamic siteId;
  CashbookFetchEvent(this.siteId);
}

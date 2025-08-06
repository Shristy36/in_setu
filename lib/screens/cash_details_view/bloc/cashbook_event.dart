part of 'cashbook_bloc.dart';

abstract class CashbookEvent{
  const CashbookEvent();
}

class CashbookFetchEvent extends CashbookEvent{
  final dynamic siteId;
  CashbookFetchEvent(this.siteId);
}

class CashBookCreateEvent extends CashbookEvent{
  dynamic siteId;
  dynamic cashBookName;

  CashBookCreateEvent(this.siteId, this.cashBookName);
}

class UpdateCashBookEvent extends CashbookEvent{
  dynamic cashBookId;
  dynamic siteId;
  dynamic cashBookName;

  UpdateCashBookEvent({required this.cashBookId,required this.siteId,required this.cashBookName});
}

class DeleteCashBookEvent extends CashbookEvent{
  dynamic cashBookId;
  DeleteCashBookEvent({required this.cashBookId});
}

class SetDefaultCashBookEvent extends CashbookEvent{
  dynamic cashBookId;
  String cashBookName;
  dynamic userId;
  dynamic siteId;
  dynamic isDefault;
  bool clicked;
  SetDefaultCashBookEvent({required this.cashBookId, required this.cashBookName, required this.userId, required this.siteId, required this.isDefault, required this.clicked});
}

class AddTransactionCashBookEvent extends CashbookEvent{
  dynamic bookId;
  dynamic siteId;
  bool toggleValue;
  dynamic amount;
  dynamic remark;
  dynamic currentDate;
  AddTransactionCashBookEvent({required this.bookId, required this.siteId, required this.toggleValue, required this.amount, required this.remark, required this.currentDate});
}
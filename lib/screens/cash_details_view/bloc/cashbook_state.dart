part of 'cashbook_bloc.dart';

class CashbookStateSuccess<T> extends GlobalApiResponseState<T>{
  CashbookStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, data: data, message: message);
}

class CashBookCreateStateSuccess<T> extends GlobalApiResponseState<T>{
  CashBookCreateStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, data: data, message: message);
}
class UpdateCashBookStateSuccess<T> extends GlobalApiResponseState<T>{
  UpdateCashBookStateSuccess({
    T? data,
    String message = '',
  }):super(status: GlobalApiStatus.completed, data: data, message: message);
}
class AddTransactionCashBookStateSuccess<T> extends GlobalApiResponseState<T>{
  AddTransactionCashBookStateSuccess({
    T? data,
    String message = '',
  }):super(status: GlobalApiStatus.completed, data: data, message: message);
}
class DeleteCashBookStateSuccess<T> extends GlobalApiResponseState<T>{
  DeleteCashBookStateSuccess({
    T? data,
    String message = '',
  }):super(status: GlobalApiStatus.completed, data: data, message: message);
}
class SetDefaultCashBookStateSuccess<T> extends GlobalApiResponseState<T>{
  SetDefaultCashBookStateSuccess({
    T? data,
    String message = '',
  }):super(status: GlobalApiStatus.completed, data: data, message: message);

}
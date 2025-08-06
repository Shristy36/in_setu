part of 'cashbook_bloc.dart';

class CashbookStateSuccess<T> extends GlobalApiResponseState<T>{
  CashbookStateSuccess({
    T? data,
    String message = '',
}):super(status: GlobalApiStatus.completed, data: data, message: message);
}

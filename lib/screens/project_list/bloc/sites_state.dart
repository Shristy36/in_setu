part of 'sites_bloc.dart';

class AllSiteStateSuccess<T> extends GlobalApiResponseState<T> {
  AllSiteStateSuccess({T? data, String message = ''})
      : super(status: GlobalApiStatus.completed, message: message, data: data);
}

class SitesCreateStateSuccess<T> extends GlobalApiResponseState<T> {
  SitesCreateStateSuccess({
    T? data,
    String message = '',
  }) :super(status: GlobalApiStatus.completed, message: message, data: data);
}

class SiteDeleteStateSuccess<T> extends GlobalApiResponseState<T> {
  SiteDeleteStateSuccess({
    T? data,
    String message = '',
  }) :super(status: GlobalApiStatus.completed, message: message, data: data);
}

class SiteUpdateStateSuccess<T> extends GlobalApiResponseState<T> {
  SiteUpdateStateSuccess({
    T? data,
    String message = '',
  }) :super(status: GlobalApiStatus.completed, message: message, data: data);
}
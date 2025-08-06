/// success : true
/// message : "Sites successfully created"

class CreateSiteResponse {
  CreateSiteResponse({
      bool? success, 
      String? message,}){
    _success = success;
    _message = message;
}

  CreateSiteResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
  }
  bool? _success;
  String? _message;
CreateSiteResponse copyWith({  bool? success,
  String? message,
}) => CreateSiteResponse(  success: success ?? _success,
  message: message ?? _message,
);
  bool? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}
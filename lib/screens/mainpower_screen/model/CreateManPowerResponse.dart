/// success : true
/// message : "Sites successfully created"

class CreateManPowerResponse {
  CreateManPowerResponse({
      bool? success, 
      String? message,}){
    _success = success;
    _message = message;
}

  CreateManPowerResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
  }
  bool? _success;
  String? _message;
CreateManPowerResponse copyWith({  bool? success,
  String? message,
}) => CreateManPowerResponse(  success: success ?? _success,
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
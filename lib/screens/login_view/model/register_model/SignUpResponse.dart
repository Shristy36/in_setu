/// status : true
/// otp : "6308"
/// message : "Otp Send on Registered Mobile No"

class SignUpResponse {
  SignUpResponse({
      bool? status, 
      String? otp, 
      String? message,}){
    _status = status;
    _otp = otp;
    _message = message;
}

  SignUpResponse.fromJson(dynamic json) {
    _status = json['status'];
    _otp = json['otp'];
    _message = json['message'];
  }
  bool? _status;
  String? _otp;
  String? _message;
SignUpResponse copyWith({  bool? status,
  String? otp,
  String? message,
}) => SignUpResponse(  status: status ?? _status,
  otp: otp ?? _otp,
  message: message ?? _message,
);
  bool? get status => _status;
  String? get otp => _otp;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['otp'] = _otp;
    map['message'] = _message;
    return map;
  }

}
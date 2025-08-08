/// success : true
/// reset_otp : "183918"
/// reset_token : "768e78024aa8fdb9b8fe87be86f64745cdf432c0aa"
/// message : "Reset Email Sent Successfully."

class ResetRequestResponse {
  ResetRequestResponse({
      bool? success, 
      String? resetOtp, 
      String? resetToken, 
      String? message,}){
    _success = success;
    _resetOtp = resetOtp;
    _resetToken = resetToken;
    _message = message;
}

  ResetRequestResponse.fromJson(dynamic json) {
    _success = json['success'];
    _resetOtp = json['reset_otp'];
    _resetToken = json['reset_token'];
    _message = json['message'];
  }
  bool? _success;
  String? _resetOtp;
  String? _resetToken;
  String? _message;
ResetRequestResponse copyWith({  bool? success,
  String? resetOtp,
  String? resetToken,
  String? message,
}) => ResetRequestResponse(  success: success ?? _success,
  resetOtp: resetOtp ?? _resetOtp,
  resetToken: resetToken ?? _resetToken,
  message: message ?? _message,
);
  bool? get success => _success;
  String? get resetOtp => _resetOtp;
  String? get resetToken => _resetToken;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['reset_otp'] = _resetOtp;
    map['reset_token'] = _resetToken;
    map['message'] = _message;
    return map;
  }

}
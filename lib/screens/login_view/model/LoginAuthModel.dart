/// access_token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ1c2VyX2RhdGEiOiJRWElyUXpobE9FWk9OMk41VUhKeGFVWlBZV2xuYjNsUlIyWlhaM0Z5VVVSMmMyVkZja2xVVUhoWk5FcHpjRFJSVTBKS05rNUlZa0ZGY2xnNEwyRTVRbkl4Wkc4MFVtWTJRMlZzY1V4UmJqZHpZbEpEVDFOeWJsaGFWWFpRVlhnM0sySlFabU5vTW1oVGFVRTkiLCJpYXQiOjE3NTE4NzI5MDQsImV4cCI6MTc1MjEzMjEwNH0.YTn25g5KPFYV6YwM43UMEH4v2HfLJd4P34V31TWRoeUrNyixBwqxkwnEB78bb91W34sAIMdjsQvNDK3U60ajyU8mxrQnQa_A5lR30jab-dfG2NQ5XyLOcE9wGlndlEedUJUCXmhobe4cAsGSNpxBMj24qtPqp7mjMr5WiRZPZIHurYXI0kBV5GBEu1HDh7ohap_sTJJZEd-jsnIMIn24SfNzCZwvZJJGsLBvr9B98qgvGYXbdprwVoiw7jkzFjqWnk_6z9jNtwsa3AU2MK6YtxgDUDX_mJNa9MMs8CDAQLutBRlDczuIsHIRQFpYiHXA6ynDhyQ7CEbkk8x7VTJ_Dg"
/// status : true
/// permission : null
/// user : {"first_name":"khurshid","last_name":"Kalmani","profile_image":"profile_image.png","designation":"CTO","user_mobile":"9867276387","user_directory":"78606094453f9_Khurshid","user_address":null,"user_token":"0e6ed76483101247da8886a7105b1584901918bf","email_id":"khurshid_258@yahoo.com","is_active":"1"}

class LoginAuthModel {
  LoginAuthModel({
      String? accessToken, 
      bool? status, 
      dynamic permission, 
      User? user,}){
    _accessToken = accessToken;
    _status = status;
    _permission = permission;
    _user = user;
}

  LoginAuthModel.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _status = json['status'];
    _permission = json['permission'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _accessToken;
  bool? _status;
  dynamic _permission;
  User? _user;
LoginAuthModel copyWith({  String? accessToken,
  bool? status,
  dynamic permission,
  User? user,
}) => LoginAuthModel(  accessToken: accessToken ?? _accessToken,
  status: status ?? _status,
  permission: permission ?? _permission,
  user: user ?? _user,
);
  String? get accessToken => _accessToken;
  bool? get status => _status;
  dynamic get permission => _permission;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['status'] = _status;
    map['permission'] = _permission;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// first_name : "khurshid"
/// last_name : "Kalmani"
/// profile_image : "profile_image.png"
/// designation : "CTO"
/// user_mobile : "9867276387"
/// user_directory : "78606094453f9_Khurshid"
/// user_address : null
/// user_token : "0e6ed76483101247da8886a7105b1584901918bf"
/// email_id : "khurshid_258@yahoo.com"
/// is_active : "1"

class User {
  User({
      String? firstName, 
      String? lastName, 
      String? profileImage, 
      String? designation, 
      String? userMobile, 
      String? userDirectory, 
      dynamic userAddress, 
      String? userToken, 
      String? emailId, 
      String? isActive,}){
    _firstName = firstName;
    _lastName = lastName;
    _profileImage = profileImage;
    _designation = designation;
    _userMobile = userMobile;
    _userDirectory = userDirectory;
    _userAddress = userAddress;
    _userToken = userToken;
    _emailId = emailId;
    _isActive = isActive;
}

  User.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _profileImage = json['profile_image'];
    _designation = json['designation'];
    _userMobile = json['user_mobile'];
    _userDirectory = json['user_directory'];
    _userAddress = json['user_address'];
    _userToken = json['user_token'];
    _emailId = json['email_id'];
    _isActive = json['is_active'];
  }
  String? _firstName;
  String? _lastName;
  String? _profileImage;
  String? _designation;
  String? _userMobile;
  String? _userDirectory;
  dynamic _userAddress;
  String? _userToken;
  String? _emailId;
  String? _isActive;
User copyWith({  String? firstName,
  String? lastName,
  String? profileImage,
  String? designation,
  String? userMobile,
  String? userDirectory,
  dynamic userAddress,
  String? userToken,
  String? emailId,
  String? isActive,
}) => User(  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  profileImage: profileImage ?? _profileImage,
  designation: designation ?? _designation,
  userMobile: userMobile ?? _userMobile,
  userDirectory: userDirectory ?? _userDirectory,
  userAddress: userAddress ?? _userAddress,
  userToken: userToken ?? _userToken,
  emailId: emailId ?? _emailId,
  isActive: isActive ?? _isActive,
);
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get profileImage => _profileImage;
  String? get designation => _designation;
  String? get userMobile => _userMobile;
  String? get userDirectory => _userDirectory;
  dynamic get userAddress => _userAddress;
  String? get userToken => _userToken;
  String? get emailId => _emailId;
  String? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['profile_image'] = _profileImage;
    map['designation'] = _designation;
    map['user_mobile'] = _userMobile;
    map['user_directory'] = _userDirectory;
    map['user_address'] = _userAddress;
    map['user_token'] = _userToken;
    map['email_id'] = _emailId;
    map['is_active'] = _isActive;
    return map;
  }

}
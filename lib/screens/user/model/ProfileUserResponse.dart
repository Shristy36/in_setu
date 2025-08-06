/// success : true
/// image_path : "uploads/users/78606094453f9_Khurshid/profile_image.png?v=1752472455"
/// data : {"first_name":"khurshid","last_name":"Kalmani","profile_image":"profile_image.png","designation":"CTO","user_mobile":"9867276387","user_directory":"78606094453f9_Khurshid","user_address":null,"user_token":"0e6ed76483101247da8886a7105b1584901918bf","email_id":"khurshid_258@yahoo.com","is_active":"1"}

class ProfileUserResponse {
  ProfileUserResponse({
      bool? success, 
      String? imagePath, 
      Data? data,}){
    _success = success;
    _imagePath = imagePath;
    _data = data;
}

  ProfileUserResponse.fromJson(dynamic json) {
    _success = json['success'];
    _imagePath = json['image_path'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  String? _imagePath;
  Data? _data;
ProfileUserResponse copyWith({  bool? success,
  String? imagePath,
  Data? data,
}) => ProfileUserResponse(  success: success ?? _success,
  imagePath: imagePath ?? _imagePath,
  data: data ?? _data,
);
  bool? get success => _success;
  String? get imagePath => _imagePath;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['image_path'] = _imagePath;
    if (_data != null) {
      map['data'] = _data?.toJson();
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

class Data {
  Data({
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

  Data.fromJson(dynamic json) {
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
Data copyWith({  String? firstName,
  String? lastName,
  String? profileImage,
  String? designation,
  String? userMobile,
  String? userDirectory,
  dynamic userAddress,
  String? userToken,
  String? emailId,
  String? isActive,
}) => Data(  firstName: firstName ?? _firstName,
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
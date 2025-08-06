/// success : true
/// data : [{"id":8,"site_name":"shreeji skyrise","directory_name":"shreeji_skyrise","site_location":"India ","company_name":"Mumbai","user_id":84,"team_members":"[{\"name\":\"Shyam Dai Mbank\",\"contact\":\"9851042731\",\"con_short\":\"SD\",\"con_style\":\"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#7409d6; height:75%; width:75%; \",\"isAdmin\":true},{\"name\":\"Manoj Kumar Singh Mechanical Senior\",\"contact\":\"7488631077\",\"con_short\":\"MK\",\"con_style\":\"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#b2ae92; height:75%; width:75%; \",\"isAdmin\":false},{\"name\":\"rahul chaudhari\",\"contact\":\"7581895017\",\"con_short\":\"rc\",\"con_style\":\"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#5a9e42; height:75%; width:75%; \",\"isAdmin\":false},{\"name\":\"Mosha Bhatiganj\",\"contact\":\"9826393841\",\"con_short\":\"MB\",\"con_style\":\"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#567cd9; height:75%; width:75%; \",\"isAdmin\":true}]","site_image":null,"created_at":"2025-05-23T05:58:50.000000Z","updated_at":"2025-07-02T10:31:40.000000Z","deleted_at":null,"badge":10},{"id":4,"site_name":"db ozone","directory_name":"dsdsjdbs","site_location":"djsbdjsbj","company_name":"dsjbdsjb","user_id":84,"team_members":"{\"1\":{\"name\":\"Ajay sribastab sir m3\",\"contact\":\"9907038686\",\"con_short\":\"As\",\"con_style\":\"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#742e4a; height:75%; width:75%; \",\"isAdmin\":false}}","site_image":null,"created_at":"2025-01-29T11:33:10.000000Z","updated_at":"2025-06-19T10:32:42.000000Z","deleted_at":null,"badge":10}]
/// user_data : {"first_name":"khurshid","last_name":"Kalmani","profile_image":"profile_image.png","designation":"CTO","user_mobile":"9867276387","user_directory":"78606094453f9_Khurshid","user_address":null,"user_token":"0e6ed76483101247da8886a7105b1584901918bf","email_id":"khurshid_258@yahoo.com","is_active":"1"}

class AllSitesResponse {
  AllSitesResponse({
      bool? success, 
      List<Data>? data, 
      UserData? userData,}){
    _success = success;
    _data = data;
    _userData = userData;
}

  AllSitesResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _userData = json['user_data'] != null ? UserData.fromJson(json['user_data']) : null;
  }
  bool? _success;
  List<Data>? _data;
  UserData? _userData;
AllSitesResponse copyWith({  bool? success,
  List<Data>? data,
  UserData? userData,
}) => AllSitesResponse(  success: success ?? _success,
  data: data ?? _data,
  userData: userData ?? _userData,
);
  bool? get success => _success;
  List<Data>? get data => _data;
  UserData? get userData => _userData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_userData != null) {
      map['user_data'] = _userData?.toJson();
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

class UserData {
  UserData({
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

  UserData.fromJson(dynamic json) {
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
UserData copyWith({  String? firstName,
  String? lastName,
  String? profileImage,
  String? designation,
  String? userMobile,
  String? userDirectory,
  dynamic userAddress,
  String? userToken,
  String? emailId,
  String? isActive,
}) => UserData(  firstName: firstName ?? _firstName,
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

/// id : 8
/// site_name : "shreeji skyrise"
/// directory_name : "shreeji_skyrise"
/// site_location : "India "
/// company_name : "Mumbai"
/// user_id : 84
/// team_members : "[{\"name\":\"Shyam Dai Mbank\",\"contact\":\"9851042731\",\"con_short\":\"SD\",\"con_style\":\"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#7409d6; height:75%; width:75%; \",\"isAdmin\":true},{\"name\":\"Manoj Kumar Singh Mechanical Senior\",\"contact\":\"7488631077\",\"con_short\":\"MK\",\"con_style\":\"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#b2ae92; height:75%; width:75%; \",\"isAdmin\":false},{\"name\":\"rahul chaudhari\",\"contact\":\"7581895017\",\"con_short\":\"rc\",\"con_style\":\"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#5a9e42; height:75%; width:75%; \",\"isAdmin\":false},{\"name\":\"Mosha Bhatiganj\",\"contact\":\"9826393841\",\"con_short\":\"MB\",\"con_style\":\"display: flex;justify-content: center;align-items: center; border-radius: 50px; color: white; font-size: 20px; font-weight: bold; background:#567cd9; height:75%; width:75%; \",\"isAdmin\":true}]"
/// site_image : null
/// created_at : "2025-05-23T05:58:50.000000Z"
/// updated_at : "2025-07-02T10:31:40.000000Z"
/// deleted_at : null
/// badge : 10

class Data {
  Data({
      num? id, 
      String? siteName, 
      String? directoryName, 
      String? siteLocation, 
      String? companyName, 
      num? userId, 
      String? teamMembers, 
      dynamic siteImage, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      num? badge,}){
    _id = id;
    _siteName = siteName;
    _directoryName = directoryName;
    _siteLocation = siteLocation;
    _companyName = companyName;
    _userId = userId;
    _teamMembers = teamMembers;
    _siteImage = siteImage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _badge = badge;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _siteName = json['site_name'];
    _directoryName = json['directory_name'];
    _siteLocation = json['site_location'];
    _companyName = json['company_name'];
    _userId = json['user_id'];
    _teamMembers = json['team_members'];
    _siteImage = json['site_image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _badge = json['badge'];
  }
  num? _id;
  String? _siteName;
  String? _directoryName;
  String? _siteLocation;
  String? _companyName;
  num? _userId;
  String? _teamMembers;
  dynamic _siteImage;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  num? _badge;
Data copyWith({  num? id,
  String? siteName,
  String? directoryName,
  String? siteLocation,
  String? companyName,
  num? userId,
  String? teamMembers,
  dynamic siteImage,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  num? badge,
}) => Data(  id: id ?? _id,
  siteName: siteName ?? _siteName,
  directoryName: directoryName ?? _directoryName,
  siteLocation: siteLocation ?? _siteLocation,
  companyName: companyName ?? _companyName,
  userId: userId ?? _userId,
  teamMembers: teamMembers ?? _teamMembers,
  siteImage: siteImage ?? _siteImage,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  badge: badge ?? _badge,
);
  num? get id => _id;
  String? get siteName => _siteName;
  String? get directoryName => _directoryName;
  String? get siteLocation => _siteLocation;
  String? get companyName => _companyName;
  num? get userId => _userId;
  String? get teamMembers => _teamMembers;
  dynamic get siteImage => _siteImage;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  num? get badge => _badge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['site_name'] = _siteName;
    map['directory_name'] = _directoryName;
    map['site_location'] = _siteLocation;
    map['company_name'] = _companyName;
    map['user_id'] = _userId;
    map['team_members'] = _teamMembers;
    map['site_image'] = _siteImage;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['badge'] = _badge;
    return map;
  }

}
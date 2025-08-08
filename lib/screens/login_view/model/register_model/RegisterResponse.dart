
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';

class RegisterResponse {
  final bool status;
  final String message;
  final LoginAuthModel? data;

  RegisterResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? LoginAuthModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class RegisterData {
  final String? accessToken;
  final bool? status;
  final User? user;

  RegisterData({
    this.accessToken,
    this.status,
    this.user,
  });

  factory RegisterData.fromJson(Map<dynamic, dynamic> json) {
    return RegisterData(
      accessToken: json['access_token'],
      status: json['status'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'status': status,
      'user': user?.toJson(),
    };
  }
}

/*class User {
  final String? firstName;
  final String? lastName;
  final String? profileImage;
  final String? designation;
  final String? userMobile;
  final String? userDirectory;
  final String? userAddress;
  final String? userToken;
  final String? emailId;
  final String? isActive;

  User({
    this.firstName,
    this.lastName,
    this.profileImage,
    this.designation,
    this.userMobile,
    this.userDirectory,
    this.userAddress,
    this.userToken,
    this.emailId,
    this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      profileImage: json['profile_image'],
      designation: json['designation'],
      userMobile: json['user_mobile'],
      userDirectory: json['user_directory'],
      userAddress: json['user_address'],
      userToken: json['user_token'],
      emailId: json['email_id'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'profile_image': profileImage,
      'designation': designation,
      'user_mobile': userMobile,
      'user_directory': userDirectory,
      'user_address': userAddress,
      'user_token': userToken,
      'email_id': emailId,
      'is_active': isActive,
    };
  }
}*/

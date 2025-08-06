part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class GetProfileDetails extends ProfileEvent {
  const GetProfileDetails();
}

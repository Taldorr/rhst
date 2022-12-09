part of 'profiles_bloc.dart';

abstract class ProfilesEvent extends Equatable {
  const ProfilesEvent();
}

class LoadProfilesEvent extends ProfilesEvent {
  const LoadProfilesEvent();

  @override
  List<Object> get props => [];
}

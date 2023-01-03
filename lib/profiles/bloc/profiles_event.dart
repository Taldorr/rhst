part of 'profiles_bloc.dart';

abstract class ProfilesEvent extends Equatable {
  const ProfilesEvent();
}

class LoadProfilesEvent extends ProfilesEvent {
  const LoadProfilesEvent();

  @override
  List<Object> get props => [];
}

class UpdateHumanProfilePictureEvent extends ProfilesEvent {
  final String humanId;
  final String path;
  const UpdateHumanProfilePictureEvent({required this.humanId, required this.path});

  @override
  List<Object> get props => [humanId];
}

class UpdateDogProfilePictureEvent extends ProfilesEvent {
  final String dogId;
  final String humanId;
  final String path;
  const UpdateDogProfilePictureEvent(
      {required this.dogId, required this.humanId, required this.path});

  @override
  List<Object> get props => [dogId, humanId];
}

class PutGalleryPictureEvent extends ProfilesEvent {
  final String humanId;
  final int position;
  final String picturePath;
  const PutGalleryPictureEvent(
      {required this.humanId, required this.picturePath, required this.position});

  @override
  List<Object> get props => [humanId, picturePath, position];
}

part of 'profiles_bloc.dart';

class ProfilesState extends Equatable {
  const ProfilesState({this.profiles = const []});

  final List<Dogteam> profiles;

  @override
  List<Object?> get props => [profiles];

  ProfilesState copyWith({List<Dogteam>? profiles}) {
    return ProfilesState(profiles: profiles ?? this.profiles);
  }
}

/// The initial state of ProfileState
class ProfilesInitial extends ProfilesState {
  const ProfilesInitial() : super();
}

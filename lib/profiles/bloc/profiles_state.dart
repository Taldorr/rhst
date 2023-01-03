part of 'profiles_bloc.dart';

class ProfilesState extends Equatable {
  const ProfilesState({this.profiles = const [], this.isLoading = false});

  final bool isLoading;
  final List<Human> profiles;

  @override
  List<Object?> get props => [profiles, isLoading];

  ProfilesState copyWith({List<Human>? profiles, bool? isLoading}) {
    return ProfilesState(
      profiles: profiles ?? this.profiles,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// The initial state of ProfileState
class ProfilesInitial extends ProfilesState {
  const ProfilesInitial() : super();
}

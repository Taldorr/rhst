import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rhst/profiles/repositories/profiles_repository.dart';
import 'package:rhst/util/snackbar_service.dart';
import '../models/dogteam.dart';

import 'bloc.dart';
part 'profiles_event.dart';
part 'profiles_state.dart';

class ProfilesBloc extends Bloc<ProfilesEvent, ProfilesState> {
  final ProfilesRepository _profileRepository;
  ProfilesBloc(this._profileRepository) : super(const ProfilesInitial()) {
    on<LoadProfilesEvent>(_onLoadProfilesEvent);
  }

  Future<void> _onLoadProfilesEvent(LoadProfilesEvent event, Emitter<ProfilesState> emit) async {
    try {
      final profiles = await _profileRepository.getAllDogteams();
      emit(ProfilesState(profiles: profiles));
    } catch (e) {
      SnackbarService().display("Ein Fehler ist aufgetreten: $e", isError: true);
    }
  }

  Dogteam? getTeamByHumanId(String humanId) {
    final dogTeams = state.profiles.where((team) => team.human.id == humanId);
    if (dogTeams.isEmpty) return null;
    return dogTeams.first;
  }
}

import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:rhst/profiles/models/dog.dart';
import 'package:rhst/profiles/models/gallery_reference.dart';
import 'package:rhst/profiles/models/human.dart';
import 'package:rhst/profiles/repositories/profiles_repository.dart';
import 'package:rhst/util/snackbar_service.dart';
import 'package:rhst/util/storage_service.dart';

import 'bloc.dart';

part 'profiles_event.dart';
part 'profiles_state.dart';

extension HumanListExt on List<Human> {
  List<Human> replaceById(Human updatedHuman) {
    final idx = indexWhere((h) => h.id == updatedHuman.id);
    this[idx] = updatedHuman;
    return [...this];
  }
}

extension DogListExt on List<Dog> {
  List<Dog> replaceById(Dog updatedDog) {
    final idx = indexWhere((h) => h.id == updatedDog.id);
    this[idx] = updatedDog;
    return [...this];
  }
}

class ProfilesBloc extends Bloc<ProfilesEvent, ProfilesState> {
  final ProfilesRepository _profileRepository;
  ProfilesBloc(this._profileRepository) : super(const ProfilesInitial()) {
    on<LoadProfilesEvent>(_onLoadProfilesEvent);
    on<UpdateHumanProfilePictureEvent>(_onUpdateHumanProfilePictureEvent);
    on<UpdateDogProfilePictureEvent>(_onUpdateDogProfilePictureEvent);
    on<PutGalleryPictureEvent>(_onPutGalleryPictureEvent);
  }

  Future<void> _onUpdateHumanProfilePictureEvent(
    UpdateHumanProfilePictureEvent event,
    Emitter<ProfilesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final human = state.profiles.firstWhere((human) => human.id == event.humanId);
    await _profileRepository.addHumanAvatar(event.humanId, event.path);
    final updatedHuman = human.copyWith(profilePicPath: event.path);
    emit(ProfilesState(profiles: state.profiles.replaceById(updatedHuman), isLoading: false));
  }

  Future<void> _onUpdateDogProfilePictureEvent(
    UpdateDogProfilePictureEvent event,
    Emitter<ProfilesState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final human = state.profiles.firstWhere((human) => human.id == event.humanId);
    final dogToUpdate = human.dogs.firstWhere((dog) => dog.id == event.dogId);
    await _profileRepository.addDogAvatar(event.humanId, event.dogId, event.path);
    final updatedDog = dogToUpdate.copyWith(
      profilePicPath: StorageService.dogProfilePicturePath(dogToUpdate.id!),
    );

    final updatedHuman = human.copyWith(dogs: human.dogs.replaceById(updatedDog));
    emit(ProfilesState(profiles: state.profiles.replaceById(updatedHuman), isLoading: false));
  }

  Future<void> _onPutGalleryPictureEvent(
      PutGalleryPictureEvent event, Emitter<ProfilesState> emit) async {
    emit(state.copyWith(isLoading: true));
    final human = state.profiles.firstWhere((human) => human.id == event.humanId);
    final galleryRef = GalleryReference(path: event.picturePath, position: event.position);
    await _profileRepository.addPictureToGallery(event.humanId, galleryRef);
    final updatedHuman = human.copyWith(
      galleryReferences: [...human.galleryReferences, galleryRef],
    );

    emit(ProfilesState(profiles: state.profiles.replaceById(updatedHuman), isLoading: false));
  }

  Future<void> _onLoadProfilesEvent(LoadProfilesEvent event, Emitter<ProfilesState> emit) async {
    try {
      final profiles = await _profileRepository.getAll();
      emit(ProfilesState(profiles: profiles));
    } catch (e) {
      SnackbarService().display("Ein Fehler ist aufgetreten: $e", isError: true);
    }
  }

  void updateDogProfilePicture(String filePath, String teamId, String dogId) async {
    StorageService.uploadDogProfilePicture(dogId, File(filePath))?.then((uploadTask) {
      add(UpdateDogProfilePictureEvent(
          dogId: dogId, humanId: teamId, path: uploadTask.ref.fullPath));
    });
  }

  void updateHumanProfilePicture(String filePath, String humanId) async {
    StorageService.uploadHumanProfilePicture(humanId, File(filePath))?.then((uploadTask) {
      add(UpdateHumanProfilePictureEvent(humanId: humanId, path: uploadTask.ref.fullPath));
    });
  }

  void putGalleryPicture(String filePath, int position, String humanId) async {
    StorageService.uploadGalleryPicture(humanId, File(filePath))?.then((uploadTask) {
      add(PutGalleryPictureEvent(
          humanId: humanId, position: position, picturePath: uploadTask.ref.fullPath));
    });
  }
}

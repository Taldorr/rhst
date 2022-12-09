import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rhst/appointments/models/appointment.dart';
import 'package:rhst/appointments/models/carpool.dart';
import 'package:rhst/appointments/repositories/appointments_repository.dart';
import 'package:rhst/util/snackbar_service.dart';

import 'bloc.dart';
part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final AppointmentsRepository _appointmentRepository;
  AppointmentsBloc(this._appointmentRepository) : super(const AppointmentsInitial()) {
    on<LoadAppointmentsEvent>(_onLoadAppointmentsEvent);
  }

  Future<void> _onLoadAppointmentsEvent(
      LoadAppointmentsEvent event, Emitter<AppointmentsState> emit) async {
    try {
      final appointments = await _appointmentRepository.getAllAppointments();
      emit(AppointmentsState(appointments: appointments));
    } catch (e) {
      SnackbarService().display("Ein Fehler ist aufgetreten: $e", isError: true);
    }
  }

  Future<void> upsertAppointment(String userId, Appointment appointment) async {
    try {
      return _appointmentRepository.upsertAppointment(userId, appointment);
    } catch (e) {
      SnackbarService().display("Ein Fehler ist aufgetreten: $e", isError: true);
    }
  }

  Future<void> createCarpool(String appointmentId, Carpool carpool) async {
    try {
      return _appointmentRepository.createCarpool(appointmentId, carpool);
    } catch (e) {
      SnackbarService().display("Ein Fehler ist aufgetreten: $e", isError: true);
    }
  }

  Future<List<Carpool>> getCarpoolsOfAppointment(String appointmentId) async {
    try {
      return _appointmentRepository.getCarpoolsOfAppointment(appointmentId);
    } catch (e) {
      print(e);
      SnackbarService().display("Ein Fehler ist aufgetreten: $e", isError: true);
      return [];
    }
  }

  Future<void> joinAppointment(
      String appointmentId, String humanId, List<String> dogIds, Carpool carpool) async {
    try {
      return _appointmentRepository.joinAppointment(
        appointmentId: appointmentId,
        participatingHumanId: humanId,
        participatingDogIds: dogIds,
        carpool: carpool,
      );
    } catch (e) {
      print(e);
      SnackbarService().display("Ein Fehler ist aufgetreten: $e", isError: true);
    }
  }
}

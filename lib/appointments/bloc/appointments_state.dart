part of 'appointments_bloc.dart';

class AppointmentsState extends Equatable {
  const AppointmentsState({this.appointments = const []});

  final List<Appointment> appointments;

  @override
  List<Object?> get props => [appointments];

  AppointmentsState copyWith({List<Appointment>? appointments}) {
    return AppointmentsState(appointments: appointments ?? this.appointments);
  }
}

/// The initial state of AppointmentState
class AppointmentsInitial extends AppointmentsState {
  const AppointmentsInitial() : super();
}

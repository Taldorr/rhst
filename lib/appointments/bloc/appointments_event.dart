part of 'appointments_bloc.dart';

abstract class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();
}

class LoadAppointmentsEvent extends AppointmentsEvent {
  const LoadAppointmentsEvent();

  @override
  List<Object> get props => [];
}

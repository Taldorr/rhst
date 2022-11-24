// coverage:ignore-file

part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  const AttendanceState({this.attendances = const []});

  final List<Attendance> attendances;

  @override
  List<Object?> get props => [attendances];

  AttendanceState copyWith({List<Attendance>? attendances}) {
    return AttendanceState(attendances: attendances ?? this.attendances);
  }
}

/// The initial state of AttendanceState
class AttendanceInitial extends AttendanceState {
  const AttendanceInitial() : super();
}

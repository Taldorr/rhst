// coverage:ignore-file
part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();
}

class LoadAttendanceEvent extends AttendanceEvent {
  const LoadAttendanceEvent();

  @override
  List<Object> get props => [];
}

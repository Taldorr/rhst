import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rhst/attendance/models/attendance.dart';
import 'package:rhst/util/snackbar_service.dart';

import '../repositories/attendance_repository.dart';
import 'bloc.dart';
part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository _attendanceRepository;
  AttendanceBloc(this._attendanceRepository) : super(const AttendanceInitial()) {
    on<LoadAttendanceEvent>(_onLoadAttandanceEvent);
  }

  Future<void> _onLoadAttandanceEvent(
      LoadAttendanceEvent event, Emitter<AttendanceState> emit) async {
    try {
      final attendances = await _attendanceRepository.getAllAttendances();
      emit(AttendanceState(attendances: attendances));
    } catch (e) {
      print(e);
      SnackbarService().display("Ein Fehler ist aufgetreten: $e", isError: true);
    }
  }

  FutureOr<void> cancelAttendance(String userId, DateTime? until) async {
    // set minutes and smaller to 0
    final prunedDate =
        until == null ? null : DateTime(until.year, until.month, until.day, until.hour);

    await _attendanceRepository.updateAttendance(
      userId,
      prunedDate?.millisecondsSinceEpoch,
    );

    add(const LoadAttendanceEvent());
  }
}

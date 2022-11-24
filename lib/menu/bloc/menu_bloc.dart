import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const MenuInitial()) {
    on<CustomMenuEvent>(_onCustomMenuEvent);
  }

  FutureOr<void> _onCustomMenuEvent(
    CustomMenuEvent event,
    Emitter<MenuState> emit,
  ) {
    // TODO: Add Logic
  }
}

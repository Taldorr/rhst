part of 'menu_bloc.dart';

abstract class MenuEvent  extends Equatable {
  const MenuEvent();
}

/// {@template custom_menu_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomMenuEvent extends MenuEvent {
  /// {@macro custom_menu_event}
  const CustomMenuEvent();


  @override
  List<Object> get props => [];

}

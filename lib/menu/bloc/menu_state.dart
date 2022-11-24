part of 'menu_bloc.dart';

/// {@template menu_state}
/// MenuState description
/// {@endtemplate}
class MenuState extends Equatable {
  /// {@macro menu_state}
  const MenuState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current MenuState with property changes
  MenuState copyWith({
    String? customProperty,
  }) {
    return MenuState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template menu_initial}
/// The initial state of MenuState
/// {@endtemplate}
class MenuInitial extends MenuState {
  /// {@macro menu_initial}
  const MenuInitial() : super();
}

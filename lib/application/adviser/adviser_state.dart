part of 'adviser_bloc.dart';

@immutable
abstract class AdviserState with EquatableMixin {}

class AdviserInitial extends AdviserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AdviserStateLoading extends AdviserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AdviserStateLoaded extends AdviserState {
  AdviserStateLoaded({required this.advice});
  final String advice;

  @override
  // TODO: implement props
  List<Object?> get props => [advice];
}

class AdviserStateError extends AdviserState {
  AdviserStateError({required this.message});
  final String message;

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

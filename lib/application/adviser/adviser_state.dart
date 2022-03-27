part of 'adviser_bloc.dart';

@immutable
abstract class AdviserState {}

class AdviserInitial extends AdviserState {}

class AdviserStateLoading extends AdviserState {}

class AdviserStateLoaded extends AdviserState {
  AdviserStateLoaded({required this.advice});
  final String advice;
}

class AdviserStateError extends AdviserState {
  AdviserStateError({required this.message});
  final String message;
}

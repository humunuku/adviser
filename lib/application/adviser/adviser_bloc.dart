import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/usecases/adviser_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'adviser_event.dart';
part 'adviser_state.dart';

const GENERAL_FAILURE_MESSAGE = "Something went wrong. Please try again!";
const SERVER_FAILURE_MESSAGE = "Server not reachable. Please try again!";

class AdviserBloc extends Bloc<AdviserEvent, AdviserState> {
  final AdviserUseCases useCases;

  AdviserBloc({required this.useCases}) : super(AdviserInitial()) {
    on<AdviceRequestedEvent>(
      ((event, emit) async {
        emit(AdviserStateLoading());

        Either<Failure, AdviceEntity> adviceOrFailure =
            await useCases.getAdviceUseCase();

        adviceOrFailure.fold((failure) {
          emit(AdviserStateError(message: _mapFailureToMessage(failure)));
        }, (advice) {
          emit(AdviserStateLoaded(advice: advice.advice));
        });
      }),
    );
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case GeneralFailure:
        return GENERAL_FAILURE_MESSAGE;
      default:
        return GENERAL_FAILURE_MESSAGE;
    }
  }
}

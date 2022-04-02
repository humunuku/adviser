import 'package:adviser/application/adviser/adviser_bloc.dart';
import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/usecases/adviser_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'adviser_bloc_test.mocks.dart';

@GenerateMocks([AdviserUseCases])
void main() {
  late MockAdviserUseCases mockAdviserUseCases;
  late AdviserBloc adviserBloc;

  setUp(() {
    mockAdviserUseCases = MockAdviserUseCases();
    adviserBloc = AdviserBloc(useCases: mockAdviserUseCases);
  });

  test("Init state should be AdviserInitial()", () {
    // assert:
    expect(adviserBloc.state, AdviserInitial());
  });

  group("AdviceRequestedEvent", () {
    final testAdvice = AdviceEntity(id: 1, advice: "Test");
    final testAdviceString = "Test";

    test("should call usecase after receiving AdviceRequestedEvent", () async {
      // arrange:
      when(mockAdviserUseCases.getAdviceUseCase())
          .thenAnswer((_) async => Right(testAdvice));

      // act:
      adviserBloc.add(AdviceRequestedEvent());
      await untilCalled(mockAdviserUseCases.getAdviceUseCase());

      // assert:
      verify(mockAdviserUseCases.getAdviceUseCase());
      verifyNoMoreInteractions(mockAdviserUseCases);
    });

    test("should emit loading, then loaded state after event is added.",
        () async {
      // arrange:
      when(mockAdviserUseCases.getAdviceUseCase())
          .thenAnswer((_) async => Right(testAdvice));

      // assert later:
      final expectedStates = [
        AdviserStateLoading(),
        AdviserStateLoaded(advice: testAdviceString)
      ];

      // assert:
      expectLater(adviserBloc.stream, emitsInOrder(expectedStates));

      // act:
      adviserBloc.add(AdviceRequestedEvent());
    });

    test(
        "should emit loading, then error state after event is added. -> usecase failed! -> Server Failure!",
        () async {
      // arrange:
      when(mockAdviserUseCases.getAdviceUseCase())
          .thenAnswer((_) async => Left(ServerFailure()));

      // assert later:
      final expectedStates = [
        AdviserStateLoading(),
        AdviserStateError(message: SERVER_FAILURE_MESSAGE)
      ];

      // assert:
      expectLater(adviserBloc.stream, emitsInOrder(expectedStates));

      // act:
      adviserBloc.add(AdviceRequestedEvent());
    });

    test(
        "should emit loading, then error state after event is added. -> usecase failed! -> General Failure!",
        () async {
      // arrange:
      when(mockAdviserUseCases.getAdviceUseCase())
          .thenAnswer((_) async => Left(GeneralFailure()));

      // assert later:
      final expectedStates = [
        AdviserStateLoading(),
        AdviserStateError(message: GENERAL_FAILURE_MESSAGE)
      ];

      // assert:
      expectLater(adviserBloc.stream, emitsInOrder(expectedStates));

      // act:
      adviserBloc.add(AdviceRequestedEvent());
    });
  });
}

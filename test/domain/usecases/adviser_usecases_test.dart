import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/repositories/adviser_repository.dart';
import 'package:adviser/domain/usecases/adviser_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'adviser_usecases_test.mocks.dart';

@GenerateMocks([AdviserRepository])
void main() {
  late AdviserUseCases adviserUsecases;
  late MockAdviserRepository mockAdviserRepository;

  setUp(() {
    mockAdviserRepository = MockAdviserRepository();
    adviserUsecases = AdviserUseCases(mockAdviserRepository);
  });

  group("getAdviceUseCase", () {
    final testAdvice = AdviceEntity(id: 1, advice: "test");

    test("should return the same advice as repo", () async {
      // arrange
      when(mockAdviserRepository.getAdviceFromApi())
          .thenAnswer((_) async => Right(testAdvice));

      // act
      final result = await adviserUsecases.getAdviceUseCase();

      // assert
      expect(result, Right(testAdvice));
      verify(mockAdviserRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdviserRepository);
    });

    test("should return the same failure as repo", () async {
      // arrange
      when(mockAdviserRepository.getAdviceFromApi())
          .thenAnswer((_) async => Left(ServerFailure()));

      // act
      final result = await adviserUsecases.getAdviceUseCase();

      // assert
      expect(result, Left(ServerFailure()));
      verify(mockAdviserRepository.getAdviceFromApi());
      verifyNoMoreInteractions(mockAdviserRepository);
    });
  });
}

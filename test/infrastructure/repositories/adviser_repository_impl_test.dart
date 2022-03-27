import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/repositories/adviser_repository.dart';
import 'package:adviser/infrastructure/datasources/adviser_remote_datasource.dart';
import 'package:adviser/infrastructure/models/advice_model.dart';
import 'package:adviser/infrastructure/repositories/adviser_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'adviser_repository_impl_test.mocks.dart';

@GenerateMocks([AdviserRemoteDatasource])
void main() {
  late AdviserRepository adviserRepositoryImpl;
  late MockAdviserRemoteDatasource mockAdviserRemoteDatasource;

  setUp(() {
    mockAdviserRemoteDatasource = MockAdviserRemoteDatasource();
    adviserRepositoryImpl = AdviserRepositoryImpl(
        adviserRemoteDataSource: mockAdviserRemoteDatasource);
  });

  // Create one group for every function! And within the group the differenz unit tests.
  group("getAdviceFromApi", () {
    final testAdviceModel = AdviceModel(id: 1, advice: "advice");
    final AdviceEntity testAdvice = testAdviceModel;
    test(
        "should return remote data if the call to remote datasource is successful",
        () async {
      // arrange
      when(mockAdviserRemoteDatasource.getRandomAdviceFromApi())
          .thenAnswer((_) async => testAdviceModel);

      // act
      final result = await adviserRepositoryImpl.getAdviceFromApi();

      //assert
      verify(mockAdviserRemoteDatasource.getRandomAdviceFromApi());
      expect(result, Right(testAdvice));
      verifyNoMoreInteractions(mockAdviserRemoteDatasource);
    });
  });
}

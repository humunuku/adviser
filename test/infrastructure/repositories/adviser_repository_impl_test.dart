import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/infrastructure/datasources/adviser_remote_datasource.dart';
import 'package:adviser/infrastructure/repositories/adviser_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'adviser_repository_impl_test.mocks.dart';

@GenerateMocks([AdviserRemoteDatasource])
void main() {
  late AdviserRepositoryImpl adviserRepositoryImpl;
  late MockAdviserRemoteDatasource mockAdviserRemoteDatasource;

  setUp(() {
    mockAdviserRemoteDatasource = MockAdviserRemoteDatasource();
    adviserRepositoryImpl = AdviserRepositoryImpl(
        adviserRemoteDataSource: mockAdviserRemoteDatasource);
  });

  group("getAdviceFromApi", () {
    test("should return advice from api", () {
      final result = adviserRepositoryImpl.getAdviceFromApi();
    });
  });
}

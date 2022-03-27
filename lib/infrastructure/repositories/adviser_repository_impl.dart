import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/entities/advice_entity.dart';
import 'package:adviser/domain/repositories/adviser_repository.dart';
import 'package:adviser/infrastructure/datasources/adviser_remote_datasource.dart';
import 'package:adviser/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

class AdviserRepositoryImpl extends AdviserRepository {
  AdviserRepositoryImpl({required this.adviserRemoteDataSource});
  AdviserRemoteDatasource adviserRemoteDataSource;

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi() async {
    AdviceEntity remoteAdvice;

    try {
      remoteAdvice = await adviserRemoteDataSource.getRandomAdviceFromApi();
      return Right(remoteAdvice);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }
}

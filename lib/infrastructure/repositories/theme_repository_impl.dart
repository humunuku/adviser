import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/repositories/theme_repository.dart';
import 'package:adviser/infrastructure/datasources/theme_local_datasource.dart';
import 'package:dartz/dartz.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl({required this.themeLocalDatasource});

  final ThemeLocalDatasource themeLocalDatasource;

  // if you have remote and local datasources:
  // final ThemeRemoteDatasource themeRemoteDatasource;

  @override
  Future<Either<Failure, bool>> getThemeMode() async {
    // here you could dicide which datasource to use depending on network connectivity or sth like that.

    try {
      final result = await themeLocalDatasource.getChachedThemeData();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> setThemeMode({required bool mode}) {
    return themeLocalDatasource.cacheThemeData(mode: mode);
  }
}

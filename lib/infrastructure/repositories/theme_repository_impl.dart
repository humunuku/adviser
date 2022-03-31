import 'package:adviser/domain/failures/failures.dart';
import 'package:adviser/domain/repositories/theme_repository.dart';
import 'package:adviser/infrastructure/datasources/theme_local_datasource.dart';
import 'package:dartz/dartz.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  ThemeRepositoryImpl({required this.themeLocalDatasource});

  final ThemeLocalDatasource themeLocalDatasource;

  // Wenn man local und remote hat:
  // final ThemeRemoteDatasource themeRemoteDatasource;

  @override
  Future<Either<Failure, bool>> getThemeMode() {
    // TODO: implement getThemeMode
    throw UnimplementedError();
  }

  @override
  Future<void> setThemeMode() {
    // TODO: implement setThemeMode
    throw UnimplementedError();
  }
}

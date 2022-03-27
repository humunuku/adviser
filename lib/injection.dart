import 'package:adviser/application/adviser/adviser_bloc.dart';
import 'package:adviser/domain/repositories/adviser_repository.dart';
import 'package:adviser/domain/usecases/adviser_usecases.dart';
import 'package:adviser/infrastructure/datasources/adviser_remote_datasource.dart';
import 'package:adviser/infrastructure/repositories/adviser_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final sl = GetIt
    .instance; // sl == service locator , GetIt.I als Initialisierung auch möglich

Future<void> init() async {
  //! Blocs
  sl.registerFactory(() => AdviserBloc(
      useCases: sl())); //Factory: Gib mir jedes mal ein neues Objekt.

  //! Usecases
  sl.registerLazySingleton(() =>
      AdviserUseCases(sl())); //Singleton: Gib mir immer das gleiche Objekt.

  //! Repos
  sl.registerLazySingleton<AdviserRepository>(
      () => AdviserRepositoryImpl(adviserRemoteDataSource: sl()));

  //! Datasources
  sl.registerLazySingleton<AdviserRemoteDatasource>(
      () => AdviserRemoteDatasourceImpl(client: sl()));

  //! Ext.
  sl.registerLazySingleton(() => http.Client());
}

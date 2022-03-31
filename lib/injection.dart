import 'package:adviser/application/adviser/adviser_bloc.dart';
import 'package:adviser/domain/repositories/adviser_repository.dart';
import 'package:adviser/domain/repositories/theme_repository.dart';
import 'package:adviser/domain/usecases/adviser_usecases.dart';
import 'package:adviser/infrastructure/datasources/adviser_remote_datasource.dart';
import 'package:adviser/infrastructure/datasources/theme_local_datasource.dart';
import 'package:adviser/infrastructure/repositories/adviser_repository_impl.dart';
import 'package:adviser/infrastructure/repositories/theme_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  sl.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(themeLocalDatasource: sl()));

  //! Datasources
  sl.registerLazySingleton<AdviserRemoteDatasource>(
      () => AdviserRemoteDatasourceImpl(client: sl()));

  sl.registerLazySingleton<ThemeLocalDatasource>(
      () => ThemeLocalDatasourceImpl(sharedPreferences: sl()));

  //! Ext.
  sl.registerLazySingleton(() => http.Client());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

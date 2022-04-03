import 'package:adviser/application/adviser/adviser_bloc.dart';
import 'package:adviser/application/theme/theme_service.dart';
import 'package:adviser/injection.dart';
import 'package:adviser/presentation/adviser/adviser_page.dart';
import 'package:adviser/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'injection.dart' as di; // di == dependency injection

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await di.sl<ThemeService>().init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => di.sl<ThemeService>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
          title: "Adviser",
          home: BlocProvider(
            create: ((context) => sl<AdviserBloc>()),
            child: const AdviserPage(),
          ),
        );
      },
    );
  }
}

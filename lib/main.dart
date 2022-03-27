import 'package:adviser/application/adviser/adviser_bloc.dart';
import 'package:adviser/injection.dart';
import 'package:adviser/presentation/adviser/adviser_page.dart';
import 'package:adviser/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di; // di == dependency injection

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      title: "Adviser",
      home: BlocProvider(
        create: ((context) => sl<AdviserBloc>()),
        child: const AdviserPage(),
      ),
    );
  }
}

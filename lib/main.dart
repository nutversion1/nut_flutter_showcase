import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nut_flutter_showcase/simple_bloc_observer.dart';

import 'services/api_service.dart';
import 'home_screen.dart';

final locator = GetIt.instance;

void main() {
  _setupLocator();
  //Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

void _setupLocator() {
  locator.registerSingleton<ApiService>(ApiService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nut's Flutter Showcase",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

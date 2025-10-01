import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodozzz/bloc/cart/bloc.dart';
import 'package:foodozzz/bloc/foodjoint/bloc.dart';
import 'package:foodozzz/bloc/foodjoint/event.dart';
import 'package:foodozzz/bloc/foodjoint/services.dart';
import 'package:foodozzz/bloc/menu/bloc.dart';
import 'package:foodozzz/bloc/menu/services.dart';
import 'package:foodozzz/presentation/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FJServices fjServices = FJServices();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FJBloc(fjServices)..add(FetchFJ()),
        ),
        BlocProvider(
          create: (_) => MenuBloc(menuServices: MenuServices()),
        ),
        BlocProvider(
          create: (_) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}



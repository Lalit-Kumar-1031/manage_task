import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_task/features/login/presentation/blocs/login/login_bloc.dart';
import 'package:manage_task/features/login/presentation/blocs/logout/logout_bloc.dart';
import 'package:manage_task/features/login/presentation/blocs/refresh_token/refresh_token_bloc.dart';
import 'package:manage_task/features/login/presentation/page/login_screen.dart';
import 'package:manage_task/features/signup/presentation/blocs/signup/signup_bloc.dart';
import 'package:manage_task/features/signup/presentation/page/signup_screen.dart';
import 'package:manage_task/features/user_data/presentation/blocs/user_data/user_data_bloc.dart';
import 'package:manage_task/features/user_data/presentation/page/home_screen.dart';
import 'package:manage_task/local_storage/store_token.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RefreshTokenBloc()),
        BlocProvider(create: (context) => UserDataBloc()),
        BlocProvider(create: (context) => LogoutBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  ValueNotifier<String?> refreshToken = ValueNotifier("");

  @override
  void initState() {
    // TODO: implement initState

    context.read<UserDataBloc>().add(FetchUserDataEvent());
    TokenStorage.getToken("refreshToken").then((value) {
      log("Token ==>$value");
      refreshToken.value = value;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("refresh ==>$refreshToken");
    return MaterialApp(
      title: 'Task Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF9F9F9)),
        primaryColor: const Color(0xFFF9F9F9),
      ),
      home: ValueListenableBuilder(
        valueListenable: refreshToken,
        builder: (context, value, child) {
          return (refreshToken.value == "" || refreshToken.value == null)
              ? LoginScreen()
              : BlocBuilder<UserDataBloc, UserDataState>(
                  builder: (context, state) {
                    log("User Data State ==>$state");
                    if (state is UserDataFailure && state.statusCode == 401) {
                      return HomeScreen();
                    } else if (state is UserDataSuccess) {
                      return HomeScreen();
                    }
                    return SignupScreen();
                  },
                );
        },
      ),
    );
  }
}

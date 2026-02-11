import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_task/features/login/presentation/blocs/login/login_bloc.dart';
import 'package:manage_task/features/login/presentation/blocs/logout/logout_bloc.dart';
import 'package:manage_task/features/login/presentation/blocs/refresh_token/refresh_token_bloc.dart';
import 'package:manage_task/features/login/presentation/page/login_screen.dart';
import 'package:manage_task/features/user_data/presentation/blocs/user_data/user_data_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<LoginBloc>().add(ResetLoginEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogoutBloc, LogoutState>(
      builder: (context, state) {
        log("Logout State in Home Screen => $state");
        if (state is LogoutSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
            );
          });
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Welcome To Home"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  context.read<LogoutBloc>().add(LogoutUserEvent());
                },
                child: state is LogoutLoading
                    ? CircularProgressIndicator()
                    : Text("Logout"),
              ),
              SizedBox(width: 20),
            ],
          ),
          body: SafeArea(
            child: Center(
              child: BlocListener<RefreshTokenBloc, RefreshTokenState>(
                listener: (context, state) {
                  if (state is RefreshTokenSuccess) {
                    context.read<UserDataBloc>().add(FetchUserDataEvent());
                  }
                },
                child: BlocConsumer<UserDataBloc, UserDataState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    log("User Data State ==> $state");
                    if (state is UserDataFailure && state.statusCode == 401) {
                      log("Refresh Token ==>Trigger");
                      context.read<RefreshTokenBloc>().add(
                        GetNewAccessTokenEvent(),
                      );
                    }
                    if (state is UserDataSuccess) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Text("Welcome to Home"),
                          Text("Name : ${state.userModel.name}"),
                          Text("Email : ${state.userModel.email}"),
                        ],
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 16,
                          children: [
                            CircularProgressIndicator(color: Colors.pink),
                            Text("Please Wait, Fetch the user data..."),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

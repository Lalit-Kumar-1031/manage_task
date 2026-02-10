import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_task/features/common/common_container.dart';
import 'package:manage_task/features/common/ontap_animation.dart';
import 'package:manage_task/features/login/presentation/blocs/login/login_bloc.dart';
import 'package:manage_task/features/login/presentation/blocs/logout/logout_bloc.dart';
import 'package:manage_task/features/signup/presentation/page/signup_screen.dart';
import 'package:manage_task/features/signup/presentation/widgets/custom_text_field.dart';
import 'package:manage_task/features/user_data/presentation/page/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    context.read<LogoutBloc>().add(ResetLogoutUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LoginSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false,
              );
            });
          } else if (state is LoginLoading) {
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  CircularProgressIndicator(color: Colors.pink),
                  Text("Please Wait, We're Verifying the details"),
                ],
              ),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CommonContainerDecoration(
                    borderRadius: 24,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          "User Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: emailController,
                                label: "Email",
                                hint: "Enter your email",
                                keyboardType: TextInputType.emailAddress,
                                validator: Validators.email,
                                prefixIcon: const Icon(Icons.email_outlined),
                              ),

                              const SizedBox(height: 16),

                              CustomTextField(
                                controller: passwordController,
                                label: "Password",
                                hint: "Enter your password",
                                isPassword: true,
                                validator: Validators.password,
                                prefixIcon: const Icon(Icons.lock_outline),
                              ),

                              const SizedBox(height: 24),

                              ClickAnimation(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(
                                      LoginVerificationEvent(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Dont have any account,"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignupScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Signup Now",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

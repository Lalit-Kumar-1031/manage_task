import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_task/features/common/common_container.dart';
import 'package:manage_task/features/common/ontap_animation.dart';
import 'package:manage_task/features/common/utils.dart';
import 'package:manage_task/features/login/presentation/page/login_screen.dart';
import 'package:manage_task/features/signup/presentation/blocs/signup/signup_bloc.dart';
import 'package:manage_task/features/signup/presentation/widgets/custom_text_field.dart';
import 'package:manage_task/features/user_data/presentation/blocs/user_data/user_data_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    context.read<UserDataBloc>().add(ResetFetchUserDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupFailure) {
            ToastHandler().showErrorToast(
              "Something went wrong with status code ${state.statusCode}",
            );
          }
          if (state is SignupSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        },
        builder: (context, state) {
          if (state is SignupLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  CircularProgressIndicator(color: Colors.pink),
                  Text("Please Wait,Creating your account..."),
                ],
              ),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 40,
                  ),
                  child: CommonContainerDecoration(
                    borderRadius: 24,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          "User Signup",
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
                                controller: nameController,
                                label: "Name",
                                hint: "Enter your Name",
                                keyboardType: TextInputType.text,
                                validator: Validators.name,
                                prefixIcon: const Icon(Icons.person),
                              ),
                              const SizedBox(height: 16),
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
                                    context.read<SignupBloc>().add(
                                      CreateAccountEvent(
                                        name: nameController.text,
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
                                      "Sign up",
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
                                  Text("Already have any account,"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Login Now",
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

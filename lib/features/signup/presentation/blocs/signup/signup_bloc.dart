import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_task/features/signup/domain/models/user_model.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<CreateAccountEvent>(createAccountEvent);
  }

  FutureOr<void> createAccountEvent(
    CreateAccountEvent event,
    Emitter<SignupState> emit,
  ) async {
    try {
      emit(SignupLoading());
      print("function invoked");
      final response = await Dio().post(
        "http://192.168.137.1:3000/auth/register",
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "email": event.email.trim(),
          "name": event.name.trim(),
          "password": event.password.trim(),
        },
      );

      if (response.statusCode == 201) {
        log("SignUp ==>${response.data}");
        emit(SignupSuccess(userModel: UserModel.fromJson(response.data)));
      }
    } on DioException catch (e) {
      log("Sign DIO ==>${e.response}");
      emit(SignupFailure(statusCode: e.response?.statusCode ?? 401));
    } catch (e) {
      emit(SignupFailure(statusCode: 401));
    }
  }
}

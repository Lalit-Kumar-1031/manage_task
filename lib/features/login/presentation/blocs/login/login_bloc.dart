import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_task/local_storage/store_token.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginVerificationEvent>(loginVerificationEvent);
    on<ResetLoginEvent>(resetLoginEvent);
  }

  FutureOr<void> loginVerificationEvent(
    LoginVerificationEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());

      final response = await Dio().post(
        "http://192.168.137.1:3000/auth/login",
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {"email": event.email.trim(), "password": event.password.trim()},
      );

      if (response.statusCode == 200) {
        log("Login Response  =>${event.email} ${response.data}");
        final accessToken = response.data['accessToken'] ?? "";
        final refreshToken = response.data['refreshToken'] ?? "";

        await TokenStorage.saveToken(accessToken, 'accessToken');
        await TokenStorage.saveToken(refreshToken, 'refreshToken');

        emit(
          LoginSuccess(accessToken: accessToken, refreshToken: refreshToken),
        );
      }
    } on DioException catch (e) {
      log("Login DIO ==>${e.response}");
      emit(LoginFailure(statusCode: e.response?.statusCode ?? 401));
    } catch (e) {
      emit(LoginFailure(statusCode: 401));
    }
  }

  FutureOr<void> resetLoginEvent(
    ResetLoginEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginInitial());
  }
}

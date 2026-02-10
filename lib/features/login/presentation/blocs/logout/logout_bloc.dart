import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_task/local_storage/store_token.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogoutUserEvent>(logoutUserEvent);
    on<ResetLogoutUserEvent>(resetLogoutUserEvent);
  }

  FutureOr<void> logoutUserEvent(
    LogoutUserEvent event,
    Emitter<LogoutState> emit,
  ) async {
    try {
      emit(LogoutLoading());

      final accessToken = await TokenStorage.getToken("accessToken");

      final response = await Dio().post(
        "http://192.168.137.1:3000/auth/logout",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': "Bearer $accessToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        log("Logout Response  =>${response.data}");

        await TokenStorage.clearToken("accessToken");
        await TokenStorage.clearToken("refreshToken");

        emit(LogoutSuccess());
      }
    } on DioException catch (e) {
      log("Logout DIO ==>${e.response}");
      emit(LogoutFailure(statusCode: e.response?.statusCode ?? 401));
    } catch (e) {
      emit(LogoutFailure(statusCode: 401));
    }
  }

  FutureOr<void> resetLogoutUserEvent(
    ResetLogoutUserEvent event,
    Emitter<LogoutState> emit,
  ) {
    emit(LogoutInitial());
  }
}

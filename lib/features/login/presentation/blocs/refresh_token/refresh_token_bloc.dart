import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_task/local_storage/store_token.dart';

part 'refresh_token_event.dart';
part 'refresh_token_state.dart';

class RefreshTokenBloc extends Bloc<RefreshTokenEvent, RefreshTokenState> {
  RefreshTokenBloc() : super(RefreshTokenInitial()) {
    on<GetNewAccessTokenEvent>(getNewAccessTokenEvent);
  }

  FutureOr<void> getNewAccessTokenEvent(
    GetNewAccessTokenEvent event,
    Emitter<RefreshTokenState> emit,
  ) async {
    try {
      emit(RefreshTokenLoading());

      final refreshToken = await TokenStorage.getToken('refreshToken');
      log("Refresh Token ==>$refreshToken");

      final response = await Dio().post(
        "http://192.168.137.1:3000/auth/refresh",
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {"refreshToken": refreshToken},
      );

      if (response.statusCode == 200) {
        log("refresh Token =>${response.data}");
        final accessToken = response.data['accessToken'] ?? "";

        await TokenStorage.saveToken(accessToken, 'accessToken');

        emit(RefreshTokenSuccess(newAccessToken: accessToken));
      }
    } on DioException catch (e) {
      log("Refresh Token DIO ==>${e.response}");
      emit(RefreshTokenFailure(statusCode: e.response?.statusCode ?? 401));
    } catch (e) {
      emit(RefreshTokenFailure(statusCode: 401));
    }
  }
}

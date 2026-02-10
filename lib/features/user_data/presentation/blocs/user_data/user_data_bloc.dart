import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_task/features/signup/domain/models/user_model.dart';
import 'package:manage_task/local_storage/store_token.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  UserDataBloc() : super(UserDataInitial()) {
    on<FetchUserDataEvent>(fetchUserDataEvent);
  }

  FutureOr<void> fetchUserDataEvent(
    FetchUserDataEvent event,
    Emitter<UserDataState> emit,
  ) async {
    try {
      emit(UserDataLoading());

      final accessToken = await TokenStorage.getToken("accessToken");

      final response = await Dio().get(
        "http://192.168.137.1:3000/auth/user-data",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        log("UserData Response  =>${response.data}");

        emit(UserDataSuccess(userModel: UserModel.fromJson(response.data)));
      }
    } on DioException catch (e) {
      log("UserData DIO ==>${e.response}");
      emit(UserDataFailure(statusCode: e.response?.statusCode ?? 401));
    } catch (e) {
      emit(UserDataFailure(statusCode: 401));
    }
  }
}

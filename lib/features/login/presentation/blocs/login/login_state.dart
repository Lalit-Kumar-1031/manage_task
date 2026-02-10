part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

final class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

final class LoginSuccess extends LoginState {
  final String accessToken;
  final String refreshToken;

  const LoginSuccess({required this.accessToken, required this.refreshToken});
  @override
  List<Object> get props => [accessToken, refreshToken];
}

final class LoginFailure extends LoginState {
  final int statusCode;

  const LoginFailure({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}

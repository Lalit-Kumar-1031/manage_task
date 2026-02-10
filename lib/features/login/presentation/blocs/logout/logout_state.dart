part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();
}

final class LogoutInitial extends LogoutState {
  @override
  List<Object> get props => [];
}

final class LogoutLoading extends LogoutState {
  @override
  List<Object> get props => [];
}

final class LogoutSuccess extends LogoutState {
  const LogoutSuccess();
  @override
  List<Object> get props => [];
}

final class LogoutFailure extends LogoutState {
  final int statusCode;

  const LogoutFailure({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}

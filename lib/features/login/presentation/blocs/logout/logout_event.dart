part of 'logout_bloc.dart';

sealed class LogoutEvent extends Equatable {
  const LogoutEvent();
}

class LogoutUserEvent extends LogoutEvent {
  const LogoutUserEvent();

  @override
  List<Object?> get props => [];
}

class ResetLogoutUserEvent extends LogoutEvent {
  const ResetLogoutUserEvent();

  @override
  List<Object?> get props => [];
}

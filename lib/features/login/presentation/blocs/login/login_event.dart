part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginVerificationEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginVerificationEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class ResetLoginEvent extends LoginEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();
}

class CreateAccountEvent extends SignupEvent {
  final String name;
  final String email;
  final String password;

  const CreateAccountEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

part of 'signup_bloc.dart';

sealed class SignupState extends Equatable {
  const SignupState();
  @override
  List<Object> get props => [];
}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final UserModel userModel;

  const SignupSuccess({required this.userModel});
}

final class SignupFailure extends SignupState {
  final int statusCode;

  const SignupFailure({required this.statusCode});
}

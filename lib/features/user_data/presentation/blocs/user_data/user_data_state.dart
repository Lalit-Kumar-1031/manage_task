part of 'user_data_bloc.dart';

sealed class UserDataState extends Equatable {
  const UserDataState();
}

final class UserDataInitial extends UserDataState {
  @override
  List<Object> get props => [];
}

final class UserDataLoading extends UserDataState {
  @override
  List<Object> get props => [];
}

final class UserDataSuccess extends UserDataState {
  final UserModel userModel;

  const UserDataSuccess({required this.userModel});
  @override
  List<Object> get props => [userModel];
}

final class UserDataFailure extends UserDataState {
  final int statusCode;

  const UserDataFailure({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}

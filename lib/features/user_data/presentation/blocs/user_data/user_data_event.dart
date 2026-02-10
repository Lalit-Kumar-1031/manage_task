part of 'user_data_bloc.dart';

sealed class UserDataEvent extends Equatable {
  const UserDataEvent();
}

class FetchUserDataEvent extends UserDataEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

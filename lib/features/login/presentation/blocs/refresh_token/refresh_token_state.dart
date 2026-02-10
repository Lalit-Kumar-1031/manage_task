part of 'refresh_token_bloc.dart';

sealed class RefreshTokenState extends Equatable {
  const RefreshTokenState();
}

final class RefreshTokenInitial extends RefreshTokenState {
  @override
  List<Object> get props => [];
}

final class RefreshTokenLoading extends RefreshTokenState {
  @override
  List<Object> get props => [];
}

final class RefreshTokenSuccess extends RefreshTokenState {
  final String newAccessToken;

  const RefreshTokenSuccess({required this.newAccessToken});
  @override
  List<Object> get props => [newAccessToken];
}

final class RefreshTokenFailure extends RefreshTokenState {
  final int statusCode;

  const RefreshTokenFailure({required this.statusCode});
  @override
  List<Object> get props => [statusCode];
}

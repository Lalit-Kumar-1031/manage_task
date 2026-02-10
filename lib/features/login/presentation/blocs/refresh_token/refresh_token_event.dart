part of 'refresh_token_bloc.dart';

sealed class RefreshTokenEvent extends Equatable {
  const RefreshTokenEvent();
}

class GetNewAccessTokenEvent extends RefreshTokenEvent {
  const GetNewAccessTokenEvent();

  @override
  List<Object?> get props => [];
}

part of 'crypto_coin_bloc.dart';

abstract class CryptoCoinState extends Equatable {}

class CryptoCoinInitial extends CryptoCoinState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinLoading extends CryptoCoinState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinLoaded extends CryptoCoinState {
  CryptoCoinLoaded({required this.cryptoCoin});

  final CryptoCoin cryptoCoin;

  @override
  List<Object?> get props => [cryptoCoin];
}

class CryptoCoinLoadingFailure extends CryptoCoinState {
  @override
  List<Object?> get props => [];
}

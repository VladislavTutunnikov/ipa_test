import 'dart:async';

import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_detail_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_coin_event.dart';
part 'crypto_coin_state.dart';

class CryptoCoinBloc extends Bloc<CryptoCoinEvent, CryptoCoinState> {
  CryptoCoinBloc(this.coinsRepository) : super(CryptoCoinInitial()) {
    on<LoadCryptoCoin>((event, emit) async {
      try {
        if (state is! CryptoCoinLoaded) {
          emit(CryptoCoinLoading());
        }
        final cryptoCoin = await coinsRepository.getCoinDetail(event.coinCode);
        emit(CryptoCoinLoaded(cryptoCoin: cryptoCoin));
      } catch (e, st) {
        emit(CryptoCoinLoadingFailure());
        GetIt.I<Talker>().handle(e, st);
      } finally {
        event.completer?.complete();
      }
    });
  }
  final AbstractCoinsRepository coinsRepository;
}

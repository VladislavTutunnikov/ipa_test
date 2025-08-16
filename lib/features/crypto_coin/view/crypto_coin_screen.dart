import 'dart:async';
import 'dart:ffi';

import 'package:crypto_coins_list/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:crypto_coins_list/features/crypto_coin/widgets/widgets.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'dart:math';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;

  final _cryptoCoinBloc = CryptoCoinBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is String, 'You must provide string args');
    coinName = args as String;
    _cryptoCoinBloc.add(LoadCryptoCoin(coinCode: coinName ?? 'BTC'));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoCoinBloc.add(
            LoadCryptoCoin(coinCode: coinName ?? 'BTC', completer: completer),
          );
          return completer.future;
        },
        child: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
          bloc: _cryptoCoinBloc,
          builder: (context, state) {
            if (state is CryptoCoinLoaded) {
              final coin = state.cryptoCoin;
              final coinDetails = coin.details;
              return Center(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.network(coinDetails.fullImageUrl),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      coin.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    BaseCard(
                      child: Center(
                        child: Text(
                          '${coinDetails.priceInUSD} \$',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    BaseCard(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('High 24 Hour'),
                              Spacer(),
                              Text(
                                '${(coinDetails.highPriceHour).toStringAsFixed(2)} \$',
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text('Low 24 Hour'),
                              Spacer(),
                              Text(
                                '${(coinDetails.lowPriceHour).toStringAsFixed(2)} \$',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is CryptoCoinLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong...',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'Please try again later',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: 30),
                    OutlinedButton(
                      onPressed: () {
                        _cryptoCoinBloc.add(
                          LoadCryptoCoin(coinCode: coinName ?? 'BTC'),
                        );
                      },
                      child: Text('Try again'),
                    ),
                    //TextButton(onPressed: () {}, child: Text('Try again')),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

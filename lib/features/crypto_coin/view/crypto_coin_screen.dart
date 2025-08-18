import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:crypto_coins_list/features/crypto_coin/bloc/crypto_coin_bloc.dart';
import 'package:crypto_coins_list/features/crypto_coin/widgets/widgets.dart';
import 'package:crypto_coins_list/generated/l10n.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key, required this.coin});

  final CryptoCoin coin;

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  final _cryptoCoinBloc = CryptoCoinBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoCoinBloc.add(LoadCryptoCoin(coinCode: widget.coin.name));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
        bloc: _cryptoCoinBloc,
        builder: (context, state) {
          if (state is CryptoCoinLoaded) {
            final coin = state.cryptoCoin;
            final coinDetails = coin.details;
            return Center(
              child: Column(
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
                        S.of(context).priceText(coinDetails.priceInUSD),
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
                            Text(S.of(context).highPrice),
                            Spacer(),
                            Text(
                              S
                                  .of(context)
                                  .priceText(
                                    coinDetails.highPriceHour.toStringAsFixed(
                                      2,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Text(S.of(context).lowPrice),
                            Spacer(),
                            Text(
                              S
                                  .of(context)
                                  .priceText(
                                    coinDetails.lowPriceHour.toStringAsFixed(2),
                                  ),
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
                    S.of(context).errorTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    S.of(context).errorSubtitle,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 30),
                  OutlinedButton(
                    onPressed: () {
                      _cryptoCoinBloc.add(
                        LoadCryptoCoin(coinCode: widget.coin.name),
                      );
                    },
                    child: Text(S.of(context).errorButtonText),
                  ),
                  //TextButton(onPressed: () {}, child: Text('Try again')),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

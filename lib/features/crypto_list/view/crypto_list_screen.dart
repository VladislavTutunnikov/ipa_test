import 'dart:async';

import 'package:crypto_coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  final String title = 'Crypto List';

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(talker: GetIt.I<Talker>()),
                ),
              );
            },
            icon: Icon(Icons.document_scanner_outlined),
          ),
        ],
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              return ListView.separated(
                padding: EdgeInsets.only(top: 10, bottom: 15),
                separatorBuilder: (contex, index) => const Divider(),
                itemCount: state.coinsList.length,
                itemBuilder: (context, i) {
                  final coin = state.coinsList[i];
                  return CryptoCoinTile(coin: coin);
                },
              );
            }

            if (state is CryptoListLoadingFailure) {
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
                        _cryptoListBloc.add(LoadCryptoList());
                      },
                      child: Text('Try again'),
                    ),
                    //TextButton(onPressed: () {}, child: Text('Try again')),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),

      // (_cryptoCoinsList == null)
      //     ? const Center(child: CircularProgressIndicator())
      //     : ListView.separated(
      //         padding: EdgeInsets.only(top: 10, bottom: 15),
      //         separatorBuilder: (contex, index) => const Divider(),
      //         itemCount: _cryptoCoinsList!.length,
      //         itemBuilder: (context, i) {
      //           final coin = _cryptoCoinsList![i];
      //           return CryptoCoinTile(coin: coin);
      //         },
      //       ),
    );
  }
}

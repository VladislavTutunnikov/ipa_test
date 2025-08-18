import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_model.dart';
import 'package:flutter/material.dart';

import '../features/crypto_coin/crypto_coin.dart';
import '../features/crypto_list/crypto_list.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  
  @override
  List<AutoRoute> get routes => [
      AutoRoute(page: CryptoListRoute.page, path: '/'),
      AutoRoute(page: CryptoCoinRoute.page)
  ];
  }


// final routes = {
//         '/': (context) => CryptoListScreen(),
//         '/coin': (context) => CryptoCoinScreen(),
//       };
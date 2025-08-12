import 'package:flutter/material.dart';

import 'router/router.dart';
import 'theme/theme.dart';

class CryptoList extends StatelessWidget {
  const CryptoList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto List',
      theme: darkTheme,
      routes: routes,
    );
  }
}
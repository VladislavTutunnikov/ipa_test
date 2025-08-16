import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_model.dart';
import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({super.key, required this.coin});

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 55,
        width: 55,
        child: Image.network(coin.details.fullImageUrl),
      ),
      title: Text(coin.name, style: Theme.of(context).textTheme.bodyMedium),
      subtitle: Text(
        '${coin.details.priceInUSD}\$',
        style: Theme.of(context).textTheme.labelSmall,
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.of(context).pushNamed('/coin', arguments: coin.name);
      },
    );
  }
}

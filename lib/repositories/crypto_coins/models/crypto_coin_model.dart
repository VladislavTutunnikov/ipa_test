import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_detail_model.dart';
import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable{
  const CryptoCoin({
    required this.name,
    required this.details,
  });

  final String name;
  final CryptoCoinDetail details;
  
  @override
  List<Object?> get props => [name, details];
}
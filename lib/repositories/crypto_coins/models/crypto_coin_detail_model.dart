import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

part "crypto_coin_detail_model.g.dart";

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetail extends Equatable{
  const CryptoCoinDetail({
    required this.priceInUSD,
    required this.imageUrl,
    required this.highPriceHour,
    required this.lowPriceHour,
  });

  @HiveField(0)
  @JsonKey(name: 'PRICE')
  final double priceInUSD;

  @HiveField(1)
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  String get fullImageUrl => 'https://www.cryptocompare.com/$imageUrl';
  
  @HiveField(2)
  @JsonKey(name: 'HIGH24HOUR')
  final double highPriceHour;

  @HiveField(3)
  @JsonKey(name: 'LOW24HOUR')
  final double lowPriceHour;
  
  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) => _$CryptoCoinDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  @override
  List<Object?> get props => [priceInUSD, imageUrl, highPriceHour, lowPriceHour];
}

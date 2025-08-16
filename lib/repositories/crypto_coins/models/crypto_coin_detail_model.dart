import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "crypto_coin_detail_model.g.dart";

@JsonSerializable()
class CryptoCoinDetail extends Equatable{
  CryptoCoinDetail({
    required this.priceInUSD,
    required this.imageUrl,
    required this.highPriceHour,
    required this.lowPriceHour,
  });

  @JsonKey(name: 'PRICE')
  final double priceInUSD;

  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  String get fullImageUrl => 'https://www.cryptocompare.com/$imageUrl';
  
  @JsonKey(name: 'HIGH24HOUR')
  final double highPriceHour;

  @JsonKey(name: 'LOW24HOUR')
  final double lowPriceHour;
  
  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) => _$CryptoCoinDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);

  @override
  List<Object?> get props => [priceInUSD, imageUrl, highPriceHour, lowPriceHour];
}

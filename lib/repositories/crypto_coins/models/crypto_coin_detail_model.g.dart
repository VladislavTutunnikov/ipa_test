// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetail _$CryptoCoinDetailFromJson(Map<String, dynamic> json) =>
    CryptoCoinDetail(
      priceInUSD: (json['PRICE'] as num).toDouble(),
      imageUrl: json['IMAGEURL'] as String,
      highPriceHour: (json['HIGH24HOUR'] as num).toDouble(),
      lowPriceHour: (json['LOW24HOUR'] as num).toDouble(),
    );

Map<String, dynamic> _$CryptoCoinDetailToJson(CryptoCoinDetail instance) =>
    <String, dynamic>{
      'PRICE': instance.priceInUSD,
      'IMAGEURL': instance.imageUrl,
      'HIGH24HOUR': instance.highPriceHour,
      'LOW24HOUR': instance.lowPriceHour,
    };

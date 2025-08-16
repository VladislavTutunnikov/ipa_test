import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_detail_model.dart';
import 'package:dio/dio.dart';
import 'crypto_coins.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  final Dio dio;

  CryptoCoinsRepository({required this.dio});

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX,SOL,XRP,DOGE,LINK,ENA,SUI,FDUSD,PEPE,PENGU,TRX,MANTLE,WIF,SHIB,ORDI,EIGEN,S,GALA,FET,HYPE,COW,FLOKI,NEIRO,TON,CRV&tsyms=USD',
    );

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;

    final dataList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;

          final details = CryptoCoinDetail.fromJson(usdData);
      // final price = usdData['PRICE'];
      // final imageUrl = usdData['IMAGEURL'];

      return CryptoCoin(
        name: e.key,
        details: details,
      );
    }).toList();

    return dataList;
  }

  @override
  Future<CryptoCoin> getCoinDetail(String coinCode) async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$coinCode&tsyms=USD',
    );
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[coinCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);
    // final price = usdData['PRICE'];
    // final imageUrl = usdData['IMAGEURL'];
    // final highPriceHour = usdData['HIGH24HOUR'];
    // final lowPriceHour = usdData['LOW24HOUR'];

    return CryptoCoin(name: coinCode, details: details);
  }
}

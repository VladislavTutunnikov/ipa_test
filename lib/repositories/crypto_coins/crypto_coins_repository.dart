import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'crypto_coins.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({required this.dio, required this.cryptoCoinsBox});

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var dataList = <CryptoCoin>[];
    try {
      dataList = await _fetchCoinsListFromApi();
      final cryptoCoinsMap = {for (var e in dataList) e.name: e};
      await cryptoCoinsBox.putAll(cryptoCoinsMap);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      dataList = cryptoCoinsBox.values.toList();
    }
    if (dataList.isEmpty) throw Exception('Something went wrong...');
    dataList.sort(
      (a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD),
    );
    return dataList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
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

      return CryptoCoin(name: e.key, details: details);
    }).toList();
    return dataList;
  }

  @override
  Future<CryptoCoin> getCoinDetail(String coinCode) async {
    try {
      final coin = await _fetchCoinDetailsFromApi(coinCode);
      cryptoCoinsBox.put(coinCode, coin);
      return coin;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return cryptoCoinsBox.get(coinCode)!;
    }
  }

  Future<CryptoCoin> _fetchCoinDetailsFromApi(String coinCode) async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$coinCode&tsyms=USD',
    );
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[coinCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);

    return CryptoCoin(name: coinCode, details: details);
  }
}

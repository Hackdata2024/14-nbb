import 'package:binalert/coinmarketcap/view/home/model/crypto.dart';

abstract class ICryptoDataSource {
  const ICryptoDataSource();
  Future<List<Crypto>> fetchData();
}

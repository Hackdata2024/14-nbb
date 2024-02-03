import 'package:binalert/coinmarketcap/product/routing/routing_with_core.dart';
import 'package:binalert/coinmarketcap/product/widget/card/crypto_card.dart';
import 'package:binalert/coinmarketcap/view/home/model/crypto.dart';
import 'package:binalert/repositories/getdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final CryptoService cryptoService = CryptoService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late Crypto cryptoData;

  @override
  void initState() {
    super.initState();
    _fetchAndPrintCryptoData();
  }

  Future<void> _fetchAndPrintCryptoData() async {
    try {
      final cryptodata = await cryptoService.getCryptoData("DEGO");

      if (cryptodata != null) {
        print(cryptodata.symbol);
        // Print other data if needed
        setState(() {
          cryptoData = cryptodata;
        });

        // Navigate to CryptoCard when data comes
        //_openCryptoCard(cryptoData);
      } else {
        print("Failed to fetch crypto data: Data is null");
      }
    } catch (error) {
      print("Error fetching crypto data: $error");
    }
  }

  void _openCryptoCard(Crypto cryptoData) {
    _scaffoldKey.currentState?.showBottomSheet(
      (BuildContext context) {
        return CryptoCard(crypto: cryptoData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      RoutingWithCore.goTradingPage(cryptoData),
                    );
                  },
                  child: Text("hello"))
            ],
          ),
        ),
      ),
    );
  }
}

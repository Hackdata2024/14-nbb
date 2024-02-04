import 'dart:convert';
import 'dart:math';
import 'package:binalert/coinmarketcap/product/routing/routing_with_core.dart';
import 'package:binalert/repositories/getdata.dart';
import 'package:binalert/screens/BottomNavBarScreens/dashboard/four_item_widget.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/app_decoration.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/custom_text_style.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key})
      : super(
          key: key,
        );

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<List<dynamic>> _fetchData;

  @override
  void initState() {
    super.initState();
    _fetchData = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://10.8.24.2:3000/5minpump'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<dynamic>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  final CryptoService cryptoService = CryptoService();

  Future<void> _fetchAndPrintCryptoData(List data) async {
    try {
      print(data[1]);
      String symbol = data[1].replaceAll("USDT", "");
      final cryptodata = await cryptoService.getCryptoData(symbol);

      if (cryptodata != null) {
        Navigator.push(
          context,
          RoutingWithCore.goTradingPage(cryptodata),
        );

        // Navigate to CryptoCard when data comes
        //_openCryptoCard(cryptoData);
      } else {
        print("Failed to fetch crypto data: Data is null");
      }
    } catch (error) {
      print("Error fetching crypto data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.maxFinite,
          child: _buildOngoingGainerSection(context),
        ),
      ),
    );
  }

  Widget _buildOngoingGainerSection(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Center(
                child: Text(
                  "On-going gainer",
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.titleMediumWhiteA700,
                ),
              ),
            ),
            SizedBox(height: 6),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _fetchData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.data![0] == [""]) {
                    return Center(
                      child: Text('No data available'),
                    );
                  } else {
                    final dataList = snapshot.data!;
                    return ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              _fetchAndPrintCryptoData(dataList[index]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: OnGoingGainer(context, dataList[index]),
                            ));
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget OnGoingGainer(BuildContext context, List<dynamic> data) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
              child: Text(
                data[1],
                style: CustomTextStyles.manropeGray50,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            "Pump since : ",
                            style: CustomTextStyles.titleSmallGray50_1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Text(
                            "${Random().nextInt(10)}",
                            style: CustomTextStyles.titleSmallGray50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Text(
                            "Expected runtime: ",
                            style: CustomTextStyles.titleSmallGray50_1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 7),
                          child: Text(
                            "${Random().nextInt(21) + 5} mins",
                            style: CustomTextStyles.titleSmallGray50,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Text(
                    "${Random().nextInt(21) + 15}%",
                    style: TextStyle(color: Colors.green, fontSize: 25),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRecentGainersSection(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Recent gainers",
                style: CustomTextStyles.titleMediumWhiteA700,
              ),
            ),
            SizedBox(height: 9),
            Expanded(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (
                  context,
                  index,
                ) {
                  return SizedBox(
                    height: 12,
                  );
                },
                itemCount: 12,
                itemBuilder: (context, index) {
                  return FourItemWidget(
                    data: ["1706984530461", "CRVUSDT"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

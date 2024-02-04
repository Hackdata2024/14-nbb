import 'package:binalert/screens/BottomNavBarScreens/theme/app_decoration.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/custom_text_style.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class UserprofilegridItemWidget extends StatelessWidget {
  const UserprofilegridItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: EdgeInsets.all(0),
        color: appTheme.gray50.withOpacity(0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Add rounded corners
          side: BorderSide(
            color: appTheme.gray50.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Container(
          height: 200,
          width: 250,
          padding: EdgeInsets.all(8),
          decoration: AppDecoration.outlineGray.copyWith(
            borderRadius: BorderRadius.circular(15), // Add rounded corners
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 2),
                  child: Text(
                    "Last hike:",
                    style: theme.textTheme.labelLarge,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 55,
                  width: 116,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "6 hours",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "BTC",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40, // Set text color to white
                                  fontWeight:
                                      FontWeight.bold, // Set text to bold
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 4,
                                ),
                                child: Text(
                                  "+4.3",
                                  style: TextStyle(
                                    color:
                                        Colors.green, // Set text color to green
                                    fontWeight:
                                        FontWeight.bold, // Set text to bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

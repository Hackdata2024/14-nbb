import 'package:binalert/screens/BottomNavBarScreens/dashboard/four_item_widget.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/app_decoration.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/custom_text_style.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/theme_helper.dart';
import 'package:binalert/screens/BottomNavBarScreens/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                 _buildOngoingGainerSection(context),
                _buildRecentGainersSection(context),
               
              
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
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
              child: Text(
                "On-going gainer",
                style: CustomTextStyles.titleMediumWhiteA700,
              ),
            ),
            SizedBox(height: 6),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (
                context,
                index,
              ) {
                return SizedBox(
                  height: 12,
                );
              },
              itemCount: 6,
              itemBuilder: (context, index) {
                return OnGoingGainer(context);
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget OnGoingGainer (BuildContext context){

    return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 1,
              ),
              decoration: AppDecoration.outlineGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 152,
                            width: 243,
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "Dego",
                                    style: CustomTextStyles.manropeGray50,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 1),
                                        child: Text(
                                          "Pump since : ",
                                          style: CustomTextStyles
                                              .titleSmallGray50_1,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 3),
                                        child: Text(
                                          "3 mins",
                                          style:
                                              CustomTextStyles.titleSmallGray50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                                  "25 mins",
                                  style: CustomTextStyles.titleSmallGray50,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 6,
                      top: 61,
                      bottom: 13,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "34%",
                          style: theme.textTheme.titleLarge,
                        ),
                        SizedBox(height: 59),
                        // CustomImageView(
                        //   imagePath: ImageConstant.imgIcon,
                        //   height: 20.adaptSize,
                        //   width: 20.adaptSize,
                        //   alignment: Alignment.centerRight,
                        //   margin: EdgeInsets.only(right: 1),
                        // ),
                      ],
                    ),
                  ),
                ],
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
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
                return FourItemWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}

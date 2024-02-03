import 'package:binalert/screens/BottomNavBarScreens/theme/app_decoration.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/custom_text_style.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/theme_helper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FourItemWidget extends StatelessWidget {
  const FourItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 25,
      ),
      decoration: AppDecoration.outlineGray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "BTC",
            style: theme.textTheme.titleMedium,
          ),
          Opacity(
            opacity: 0.4,
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Pulled for 26 mins",
                style: CustomTextStyles.titleMediumGray50,
              ),
            ),
          ),
          Spacer(),
          Text(
            "+1.03%",
            style: theme.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

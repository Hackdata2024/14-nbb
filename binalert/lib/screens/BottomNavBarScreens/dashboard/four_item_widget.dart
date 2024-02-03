import 'package:binalert/screens/BottomNavBarScreens/theme/app_decoration.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/custom_text_style.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class FourItemWidget extends StatelessWidget {
  final List data;
  const FourItemWidget({Key? key, required this.data})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    print(data);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(data[0]));
    String formattedDate = DateFormat.yMMMMd().add_jms().format(dateTime);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 25,
      ),
      decoration: AppDecoration.outlineGray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  data[1],
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Text(
                "+1.03%",
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
          Opacity(
            opacity: 0.4,
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Started at ${formattedDate}",
                style: CustomTextStyles.titleMediumGray50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

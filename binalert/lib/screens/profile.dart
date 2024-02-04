import 'package:binalert/screens/BottomNavBarScreens/theme/app_decoration.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/custom_text_style.dart';
import 'package:binalert/screens/BottomNavBarScreens/theme/theme_helper.dart';
import 'package:binalert/screens/BottomNavBarScreens/widgets/custom_image_view.dart';
import 'package:binalert/screens/BottomNavBarScreens/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildMobileAppScreen(context),
              SizedBox(height: 18),
              Text(
                "Darsh Singh",
                style: CustomTextStyles.titleMediumWhiteA700,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "darshsingh116@gmail.com",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 17),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 33),
                  child: Text(
                    "Your  favourite cryptos",
                    style: CustomTextStyles.titleMediumWhiteA700,
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 452,
                width: double.maxFinite,
                child: _buildUserProfileGrid(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMobileAppScreen(BuildContext context) {
  return SizedBox(
    height: 224,
    width: double.maxFinite,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            margin: EdgeInsets.all(0),
            color: Colors.transparent, // Set the color to transparent
            shape: RoundedRectangleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://www.shutterstock.com/image-vector/people-illustrations-profile-examples-260nw-1270121050.jpg', // Replace with your image URL
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'John Doe', // Replace with the user's name
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'john.doe@example.com', // Replace with the user's email
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}



  /// Section Widget
  Widget _buildUserProfileGrid(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 33,
        right: 33,
        bottom: 5,
      ),
      child: GridView.builder(
        shrinkWrap:
            true, // Enables the GridView to occupy only the space required by its content
        physics:
            NeverScrollableScrollPhysics(), // Prevents scrolling within the GridView
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 76,
          crossAxisCount: 2,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return UserprofilegridItemWidget();
        },
      ),
    );
  }
}

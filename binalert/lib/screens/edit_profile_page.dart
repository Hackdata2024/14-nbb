import 'package:binalert/utils/user_control.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:binalert/constants/color_constants.dart';
import 'package:binalert/repositories/firebase_repo.dart';
import 'package:binalert/repositories/firebase_storage_repo.dart';
class EditProfilePage extends StatefulWidget {

  final Function() onUpdateProfile;

  const EditProfilePage({super.key, required this.onUpdateProfile});


  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseStoreageRepo _firebaseStoreageRepo =
        context.read<FirebaseStoreageRepo>();
    FirebaseRepository _authRepository = context.read<FirebaseRepository>();
    UserControl userControl =
        UserControl(_firebaseStoreageRepo, _authRepository);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Color.fromARGB(
            255, 29, 29, 37), // Set the background color to black
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(
                0), // Set the radius to 0 for a non-rounded shape
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 35, 38, 45),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 80, 30, 5),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Username",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _usernameController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        fillColor: Colors.black,
                        filled: true,
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Bio",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _bioController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.white,
                        ),
                        fillColor: Colors.black,
                        filled: true,
                        hintText: 'Bio',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle updating profile here
                String newUsername = _usernameController.text;
                String newBio = _bioController.text;

                userControl.editUserInfo(newUsername, newBio);
                widget.onUpdateProfile(); // Pass updated data back to the profile page
                Navigator.pop(context); // Go back to the profile page
                

                // Update user's profile with newUsername and newBio
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.13,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      myLightPurple,
                      myLightPink,
                      myLightOrange,
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}


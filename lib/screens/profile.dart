import 'package:auth_app/Work/DonerData.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final DonerData don;
  ProfilePage({required this.don});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              // Replace with the user's profile picture
              radius: 60,
              backgroundImage: NetworkImage(don.img),
            ),
            SizedBox(height: 20),
            Text(
              don.name, // Use the name from the 'don' object
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Email: ${don.email}', // Use the email from the 'don' object
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Blood Type: ${don.bl}', // Use the blood type from the 'don' object
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

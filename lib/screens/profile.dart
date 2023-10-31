import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              // Replace with the user's profile picture
              radius: 60,
              backgroundImage: AssetImage('images/profile_image.png'),
            ),
            SizedBox(height: 20),
            Text(
              'User Name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Email: user@example.com', // Replace with user information
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Blood Group: AB+', // Replace with user information
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            // Add more user information widgets as needed
          ],
        ),
      ),
    );
  }
}

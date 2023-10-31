<<<<<<< HEAD
import 'package:auth_app/Work/DonerData.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final DonerData don;
  ProfilePage({required this.don});

=======
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
>>>>>>> origin/master
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
<<<<<<< HEAD
      body: Center(
=======
      body: const Center(
>>>>>>> origin/master
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
<<<<<<< HEAD
              don.name, // Use the name from the 'don' object
=======
              'User Name',
>>>>>>> origin/master
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
<<<<<<< HEAD
              'Email: ${don.email}', // Use the email from the 'don' object
=======
              'Email: user@example.com',
>>>>>>> origin/master
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
<<<<<<< HEAD
              'Blood Type: ${don.bl}', // Use the blood type from the 'don' object
=======
              'Blood Group: AB+',
>>>>>>> origin/master
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

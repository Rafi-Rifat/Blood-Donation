import 'package:flutter/material.dart';

class PostsPage extends StatelessWidget {
  final String name;
  final String contactNumber;
  final String bloodGroup;
  final String additionalNotes;

  PostsPage({
    required this.name,
    required this.contactNumber,
    required this.bloodGroup,
    required this.additionalNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submitted Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Submitted Information:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text('Name: $name'),
            SizedBox(height: 10),
            Text('Contact Number: $contactNumber'),
            SizedBox(height: 10),
            Text('Blood Group: $bloodGroup'),
            SizedBox(height: 10),
            Text('Additional Notes: $additionalNotes'),
          ],
        ),
      ),
    );
  }
}

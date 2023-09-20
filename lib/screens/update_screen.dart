import 'package:flutter/material.dart';

class UpdatePage extends StatelessWidget {
  final bool requestAccepted;

  UpdatePage({required this.requestAccepted});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              requestAccepted ? Icons.check_circle : Icons.cancel,
              color: requestAccepted ? Colors.green : Colors.red,
              size: 100.0,
            ),
            SizedBox(height: 20.0),
            Text(
              requestAccepted
                  ? 'Your blood request has been accepted.'
                  : 'Sorry, your blood request has been declined.',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

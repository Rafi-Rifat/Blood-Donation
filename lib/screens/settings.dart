import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Blood Donation',
                    style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800]),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Donating blood is a selfless act that can save lives. It is a simple process with great importance in healthcare.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '* Conditions to Donate Blood:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800]),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    '1. You must be in good health.'
                    '\n2. You should be at least 17 years old (in most places).'
                    '\n3. You must meet weight requirements.'
                    '\n4. You must not have certain medical conditions or diseases.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Importance of Blood Donation',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800]),
                  ),
                  SizedBox(height: 10.0),
                  const Text(
                    '1. Saving Lives: Donated blood is used in surgeries, accidents, and for patients with certain medical conditions.'
                    '\n2. Health Benefits: Regular blood donation can reduce the risk of certain health issues.'
                    '\n3. Community Support: Its a way to contribute to your community and help those in need.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            const Text(
              'Contributor',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor:
                      Colors.black, // You can set the underline color.
                  decorationThickness: 2,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 167, 11, 139)),
            ),
            SizedBox(height: 40),
            const Row(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/rifat.png'),
                          radius: 40.0,
                        ),
                        SizedBox(width: 100),
                        Column(
                          children: [
                            Text(
                              'Rafi Al Saad Rifat',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'rafialsaadrifat@gmail.com',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'github : Rafi-Rifat',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            const Row(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/sajib.png'),
                          radius: 40.0,
                        ),
                        SizedBox(width: 100),
                        Column(
                          children: [
                            Text(
                              'Sajib Saha',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'sajibsaha3464@gmail.com',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'github : Sajibsahacsedu',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            const Row(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('images/shawn.png'),
                          radius: 40.0,
                        ),
                        SizedBox(width: 100),
                        Column(
                          children: [
                            Text(
                              'Md. Shawn',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'mdshawn@gmail.com',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'github : Shawn-33',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:auth_app/screens/login_screen.dart';
// import 'request.dart';

// class HomeScreen extends StatefulWidget {
//   final User user;

//   HomeScreen({required this.user});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late User _currentUser;

//   @override
//   void initState() {
//     _currentUser = widget.user;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Blood Donation',
//         ),
//         backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           // Important: Remove any padding from the ListView.
//           padding: EdgeInsets.zero,
//           children: [
//             const SizedBox(height: 100),
//             const CircleAvatar(
//               backgroundColor: Color.fromARGB(255, 255, 255, 255),
//               radius: 82,
//               backgroundImage: NetworkImage(
//                   'https://www.samenfiks.nl/wp-content/uploads/2020/02/no-profile-picture.jpg'),
//             ),
//             SizedBox(height: 10),
//             Container(
//               child: WillPopScope(
//                 onWillPop: () async {
//                   final logout = await showDialog<bool>(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text('Are you sure?'),
//                         content:
//                             const Text('Do you want to logout from this App'),
//                         actionsAlignment: MainAxisAlignment.spaceBetween,
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Logout();
//                             },
//                             child: const Text('Yes'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context, false);
//                             },
//                             child: const Text('No'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                   return logout!;
//                 },
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'NAME: ${_currentUser.displayName}',
//                         style: Theme.of(context).textTheme.bodyText1,
//                       ),
//                       const SizedBox(height: 16.0),
//                       Text(
//                         'EMAIL: ${_currentUser.email}',
//                         style: Theme.of(context).textTheme.bodyText1,
//                       ),
//                       SizedBox(height: 16.0),
//                       ElevatedButton(
//                         onPressed: () async {
//                           await FirebaseAuth.instance.signOut();

//                           Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(
//                               builder: (context) => LoginScreen(),
//                             ),
//                           );
//                         },
//                         child: const Text('Sign out'),
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(
//                               Color.fromARGB(255, 255, 4, 4)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 60),
//             ListTile(
//               leading: const Icon(Icons.home_outlined),
//               title: const Text('Home'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),

//             ListTile(
//               leading: const Icon(Icons.favorite_outlined),
//               title: const Text('Blood Request'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           RequestPage()), // Replace RequestPage() with the appropriate widget from request.dart
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.update),
//               title: const Text('Update'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.settings),
//               title: const Text('Settings'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<dynamic> Logout() async {
//     await FirebaseAuth.instance.signOut();

//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => LoginScreen(),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_app/screens/login_screen.dart';
import 'request.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _currentUser;
  int _currentIndex = 0; // Index for the selected bottom navigation item.

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Blood Donation',
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      drawer: Drawer(
        child: ListView(
            // ... Your existing drawer content ...
            ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NAME: ${_currentUser.displayName}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16.0),
            Text(
              'EMAIL: ${_currentUser.email}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: const Text('Sign out'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 255, 4, 4)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Handle bottom navigation item taps here
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            // Navigate to the Home screen
          } else if (index == 1) {
            // Navigate to the Blood Request screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RequestPage(),
              ),
            );
          } else if (index == 2) {
            // Navigate to the Update screen
          } else if (index == 3) {
            // Navigate to the Settings screen
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 2, 61, 69)),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined),
            label: 'Blood Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Update',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Future<dynamic> Logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}

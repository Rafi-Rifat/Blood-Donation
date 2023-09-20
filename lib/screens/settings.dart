// import 'package:flutter/material.dart';

// // class SettingsPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Settings'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               'General Settings',
// //               style: TextStyle(
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             SizedBox(height: 20),
// //             ListTile(
// //               title: Text('Notification Settings'),
// //               trailing: Switch(
// //                 value: true, // Set the value based on user preference
// //                 onChanged: (bool value) {
// //                   // Handle the switch state change here
// //                 },
// //               ),
// //             ),
// //             ListTile(
// //               title: Text('Dark Mode'),
// //               trailing: Switch(
// //                 value: false, // Set the value based on user preference
// //                 onChanged: (bool value) {
// //                   // Handle the switch state change here
// //                 },
// //               ),
// //             ),
// //             SizedBox(height: 20),
// //             Text(
// //               'Account Settings',
// //               style: TextStyle(
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             ElevatedButton(
// //               onPressed: () {
// //                 // Handle account settings button press
// //               },
// //               child: Text('Edit Profile'),
// //             ),
// //             SizedBox(height: 10),
// //             ElevatedButton(
// //               onPressed: () {
// //                 // Handle logout button press
// //               },
// //               child: Text('Logout'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// bool isDarkModeEnabled = false; //Initialize with the default value

// class SettingsPage extends StatelessWidget {
//   bool isDarkModeEnabled = false; // Initialize with the default value

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'General Settings',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20),
//             ListTile(
//               title: Text('Notification Settings'),
//               trailing: Switch(
//                 value: true, // Set the value based on user preference
//                 onChanged: (bool value) {
//                   // Handle the switch state change here
//                 },
//               ),
//             ),
//             ListTile(
//               title: Text('Dark Mode'),
//               trailing: Switch(
//                 value:
//                     isDarkModeEnabled, // Set the value based on user preference
//                 onChanged: (bool value) {
//                   // Update the isDarkModeEnabled variable when the switch is toggled
//                   isDarkModeEnabled = value;

//                   // Call a function to update the app's theme based on the new preference
//                   _updateTheme(value);
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Account Settings',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle account settings button press
//               },
//               child: Text('Edit Profile'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle logout button press
//               },
//               child: Text('Logout'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Function to update the app's theme based on the dark mode preference
//   void _updateTheme(bool isDarkModeEnabled) {
//     // You can define your dark theme and light theme here
//     final ThemeData darkTheme = ThemeData.dark();
//     final ThemeData lightTheme = ThemeData.light();

//     // Apply the selected theme based on the preference
//     final themeData = isDarkModeEnabled ? darkTheme : lightTheme;

//     // Update the app's theme using the MaterialApp's theme property
//     // You should have MaterialApp or Theme widget wrapping your app for this to work
//     // MaterialApp(
//     //   theme: themeData,
//     //   // ...
//     // );
//   }
// }
import 'package:flutter/material.dart';
import 'themes.dart'; // Import the themes.dart file

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false; // Initialize with the default value

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Wrap your app with MaterialApp
      debugShowCheckedModeBanner: false,
      theme: isDarkModeEnabled
          ? darkTheme
          : lightTheme, // Apply the selected theme
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'General Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('Notification Settings'),
                trailing: Switch(
                  value: true, // Set the value based on user preference
                  onChanged: (bool value) {
                    // Handle the switch state change here
                  },
                ),
              ),
              ListTile(
                title: Text('Dark Mode'),
                trailing: Switch(
                  value:
                      isDarkModeEnabled, // Set the value based on user preference
                  onChanged: (bool value) {
                    // Update the isDarkModeEnabled variable when the switch is toggled
                    setState(() {
                      isDarkModeEnabled = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle account settings button press
                },
                child: Text('Edit Profile'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle logout button press
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:auth_app/GET/controller.dart';
// import 'package:auth_app/helper/map.dart';
// import 'package:auth_app/screens/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../Databases/MakeUserList.dart';
// import 'posts.dart';

// class RequestPage extends StatefulWidget {
//   @override
//   _RequestPageState createState() => _RequestPageState();
// }

// class _RequestPageState extends State<RequestPage> {
//   // final TextEditingController nameController = TextEditingController();
//   // final TextEditingController contactNumberController = TextEditingController();
//   // final TextEditingController bloodGroupController = TextEditingController();
//   // final TextEditingController notesController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final Controller cont = Get.find();
//     LatLng yoo = LatLng(0, 0);
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Blood Request Form'),
//       // ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Please fill out the blood request form:',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Select your Blood Group',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Row(
//               children: [
//                 Column(
//                   children: [
//                     Row(
//                       children: <Widget>[
//                         Radio<String>(
//                           value: 'A+',
//                           groupValue: cont.BRequest.text,
//                           onChanged: (value) {
//                             cont.BRequest.text = value!;
//                           },
//                         ),
//                         Text('A+'),
//                       ],
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Radio<String>(
//                           value: 'B+',
//                           groupValue: cont.BRequest.text,
//                           onChanged: (value) {
//                             cont.BRequest.text = value!;
//                           },
//                         ),
//                         Text('B+'),
//                       ],
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Radio<String>(
//                           value: 'O+',
//                           groupValue: cont.BRequest.text,
//                           onChanged: (value) {
//                             cont.BRequest.text = value!;
//                           },
//                         ),
//                         Text('O+'),
//                       ],
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Radio<String>(
//                           value: 'AB+',
//                           groupValue: cont.BRequest.text,
//                           onChanged: (value) {
//                             cont.BRequest.text = value!;
//                           },
//                         ),
//                         Text('AB+'),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Row(
//                       children: <Widget>[
//                         Radio<String>(
//                           value: 'A-',
//                           groupValue: cont.BRequest.text,
//                           onChanged: (value) {
//                             cont.BRequest.text = value!;
//                           },
//                         ),
//                         Text('A-'),
//                       ],
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Radio<String>(
//                           value: 'B-',
//                           groupValue: cont.BRequest.text,
//                           onChanged: (value) {
//                             cont.BRequest.text = value!;
//                           },
//                         ),
//                         Text('B-'),
//                       ],
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Radio<String>(
//                           value: 'O-',
//                           groupValue: cont.BRequest.text,
//                           onChanged: (value) {
//                             cont.BRequest.text = value!;
//                           },
//                         ),
//                         Text('O-'),
//                       ],
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Radio<String>(
//                           value: 'AB-',
//                           groupValue: cont.BRequest.text,
//                           onChanged: (value) {
//                             cont.BRequest.text = value!;
//                           },
//                         ),
//                         Text('AB-'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             TextField(
//               controller: cont.BRequest,
//               decoration: const InputDecoration(
//                 labelText: 'Your selected blood-group',
//               ),
//             ),
//             const SizedBox(height: 10),
//             IconButton(
//               icon: Icon(
//                 Icons.location_pin,
//                 color: Colors.yellow,
//                 size: 30.0,
//               ),
//               onPressed: () {
//                 cont.pu = true;
//                 Get.to(MapSample());
//                 yoo = cont.lt;
//               },
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 try{
//                   print('111111111                    111111111111111                     1111111111111                  1           ');
//                   print(cont.BRequest.text);
//                   cont.people=await fetchUserIds1(cont.BRequest.text);
//                   print(cont.people);
//                   await cont.peopleTodoner();
//                 }catch(e){
//                   print('ERROR:$e');
//                 }
//                 cont.homeIndex=2;
//                 //Get.offAll(UpdatePage(requestAccepted: true));
//                 Get.offAll(()=>HomeScreen(user: cont.Cuser1));
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/helper/map.dart';
import 'package:auth_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Databases/MakeUserList.dart';
import 'posts.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController contactNumberController = TextEditingController();
  // final TextEditingController bloodGroupController = TextEditingController();
  // final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Controller cont = Get.find();
    LatLng yoo = LatLng(0, 0);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Blood Request Form'),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            const Center(
              child: Text(
                'Select your Blood Group',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'A+',
                          groupValue: cont.BRequest.text,
                          onChanged: (value) {
                            cont.BRequest.text = value!;
                          },
                        ),
                        Text('A+'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'B+',
                          groupValue: cont.BRequest.text,
                          onChanged: (value) {
                            cont.BRequest.text = value!;
                          },
                        ),
                        Text('B+'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'O+',
                          groupValue: cont.BRequest.text,
                          onChanged: (value) {
                            cont.BRequest.text = value!;
                          },
                        ),
                        Text('O+'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'AB+',
                          groupValue: cont.BRequest.text,
                          onChanged: (value) {
                            cont.BRequest.text = value!;
                          },
                        ),
                        Text('AB+'),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'A-',
                          groupValue: cont.BRequest.text,
                          onChanged: (value) {
                            cont.BRequest.text = value!;
                          },
                        ),
                        Text('A-'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'B-',
                          groupValue: cont.BRequest.text,
                          onChanged: (value) {
                            cont.BRequest.text = value!;
                          },
                        ),
                        Text('B-'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'O-',
                          groupValue: cont.BRequest.text,
                          onChanged: (value) {
                            cont.BRequest.text = value!;
                          },
                        ),
                        Text('O-'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'AB-',
                          groupValue: cont.BRequest.text,
                          onChanged: (value) {
                            cont.BRequest.text = value!;
                          },
                        ),
                        Text('AB-'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            TextField(
              controller: cont.BRequest,
              decoration: const InputDecoration(
                labelText: 'Your selected blood-group',
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.location_pin,
                        color: Color.fromARGB(255, 5, 110, 6),
                        size: 30.0,
                      ),
                      onPressed: () {
                        cont.pu = true;
                        Get.to(MapSample());
                        yoo = cont.lt;
                      },
                    ),
                    Text('Select Loaction'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      cont.people = await fetchUserIds1(cont.BRequest.text);
                      await cont.peopleTodoner();
                    } catch (e) {
                      print('ERROR: $e');
                    }
                    cont.homeIndex = 2;
                    //Get.offAll(UpdatePage(requestAccepted: true));
                    Get.offAll(() => HomeScreen(user: cont.Cuser1));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                        255, 188, 14, 69)), // Change the background color
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            30.0), // Adjust the border radius for roundness
                      ),
                    ),
                    elevation: MaterialStateProperty.all(
                        8), // Adjust the shadow elevation
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18), // Customize text style
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

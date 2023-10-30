// import 'package:flutter/material.dart';
// import 'posts.dart';

// class RequestPage extends StatelessWidget {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController contactNumberController = TextEditingController();
//   final TextEditingController bloodGroupController = TextEditingController();
//   final TextEditingController notesController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Blood Request Form'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Please fill out the blood request form:',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Your Name',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Contact Number',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Blood Group',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               maxLines: 3,
//               decoration: InputDecoration(
//                 labelText: 'Address',
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Get the text from the TextFields using the controllers
//                 String name = nameController.text;
//                 String contactNumber = contactNumberController.text;
//                 String bloodGroup = bloodGroupController.text;
//                 String additionalNotes = notesController.text;

//                 // Navigate to posts.dart and pass the information as arguments
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PostsPage(
//                       name: name,
//                       contactNumber: contactNumber,
//                       bloodGroup: bloodGroup,
//                       additionalNotes: additionalNotes,
//                     ),
//                   ),
//                 );
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
import 'package:auth_app/screens/update_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final Controller cont=Get.find();
    LatLng yoo=LatLng(0, 0);
    //User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Request Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please fill out the blood request form:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: cont.BRequest,
              decoration: const InputDecoration(
                labelText: 'Your Name',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed:() async {

                  cont.pu=true;
                  Get.to(MapSample());
                  yoo=cont.lt;
                  print(yoo.toString());


            },
                child: Text('Select Location'),
            ),
            // TextField(
            //   controller: contactNumberController,
            //   decoration: const InputDecoration(
            //     labelText: 'Contact Number',
            //   ),
            // ),
            // const SizedBox(height: 10),
            // TextField(
            //   controller: bloodGroupController,
            //   decoration: const InputDecoration(
            //     labelText: 'Blood Group',
            //   ),
            // ),
            // const SizedBox(height: 10),
            // TextField(
            //   controller: notesController,
            //   maxLines: 3,
            //   decoration: const InputDecoration(
            //     labelText: 'Address',
            //   ),
            // ),
            // const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try{
                  cont.people=await fetchUserIds1(cont.BRequest.text);
                  await cont.peopleTodoner();
                }catch(e){
                  print('ERROR:$e');
                }
                cont.homeIndex=2;
                //Get.offAll(UpdatePage(requestAccepted: true));
                Get.offAll(()=>HomeScreen(user: cont.Cuser1));
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

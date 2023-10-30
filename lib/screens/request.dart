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
            const Text(
              'Please fill out the blood request form:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select your Blood Group',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Column(
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
            const SizedBox(height: 10),
            IconButton(
              icon: Icon(
                Icons.location_pin,
                color: Colors.yellow,
                size: 30.0,
              ),
              onPressed: () {
                cont.pu = true;
                Get.to(MapSample());
                yoo = cont.lt;
              },
            ),
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

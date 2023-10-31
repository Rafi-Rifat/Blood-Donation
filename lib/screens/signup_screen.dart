//import 'dart:html';

import 'package:auth_app/Databases/Firestore.dart';
import 'package:auth_app/Databases/MakeUserList.dart';
import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/Work/Tree.dart';
import 'package:auth_app/common.dart';
import 'package:auth_app/helper/map.dart';
import 'package:auth_app/screens/blood.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_app/screens/home_screen.dart';
import 'package:auth_app/helper/firebase_auth.dart';
import 'package:auth_app/helper/validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:auth_app/Work/image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final Controller controller = Get.find();

  late List<Pair<String, double>> yoo;
  // final _nameTextController = TextEditingController();
  // final _emailTextController = TextEditingController();
  // final _passwordTextController = TextEditingController();
  late String bl = '01';
  LatLng lat = LatLng(0, 0);

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final Storage storage = Storage();
  String? imageUrl;

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        //_focusEmail.unfocus_focusPassword.unfocus();
      },
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color.fromARGB(255, 4, 118, 124),
        //   title: Text('Create Account'),
        //   centerTitle: true,
        // ),
        body: SingleChildScrollView(
          // padding: const EdgeInsets.all(24.0),
          padding: const EdgeInsets.only(left: 24, right: 24, top: 30),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Image.asset('images/RedDrops.png'),
                ),
                const SizedBox(height: 8.0),
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.white,
                              child: const Text(
                                "Name",
                                style: TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child: TextFormField(
                              controller: controller.nameTextController,
                              focusNode: _focusName,
                              obscureText: false,
                              validator: (value) => Validator.validateName(
                                name: value,
                              ),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Name",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.text_fields,
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.0),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.white,
                              child: const Text(
                                "Email",
                                style: TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child: TextFormField(
                              controller: controller.emailTextController,
                              focusNode: _focusEmail,
                              obscureText: false,
                              validator: (value) => Validator.validateEmail(
                                email: value,
                              ),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Email",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // TextFormField(
                      //   controller: _emailTextController,
                      //   focusNode: _focusEmail,
                      //   validator: (value) => Validator.validateEmail(
                      //     email: value,
                      //   ),
                      //   decoration: InputDecoration(
                      //     hintText: "Email",
                      //     errorBorder: UnderlineInputBorder(
                      //       borderRadius: BorderRadius.circular(6.0),
                      //       borderSide: BorderSide(
                      //         color: Colors.red,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 12.0),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.white,
                              child: const Text(
                                "Password",
                                style: TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black,
                            ),
                            child: TextFormField(
                              controller: controller.passwordTextController,
                              focusNode: _focusPassword,
                              obscureText: true,
                              validator: (value) => Validator.validatePassword(
                                password: value,
                              ),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Password",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.0),

                      // TextButton(
                      //     onPressed: () {
                      //       // Navigate to the MapSample screen using GetX
                      //       Get.to(
                      //           () => MapSample()); // Use the builder function
                      //       lat = lt!;
                      //     },
                      //     child: Text('Select Location')),
                      // SizedBox(height: 44.0),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.location_pin,
                                    color: Colors.yellow,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    // Navigate to the MapSample screen using GetX
                                    Get.to(() =>
                                        MapSample()); // Use the builder function
                                    lat = lt!;
                                  },
                                ),
                                Text('Select your location'),
                              ],
                            ),
                            SizedBox(width: 10),
                            TextButton(
                                onPressed: () {
                                  // Navigate to the MapSample screen using GetX
                                  Get.to(() =>
                                      blood()); // Use the builder function
                                  lat = lt!;
                                },
                                child: Text('Blood Group')),
                            FloatingActionButton(
                              onPressed: () async {
                                final results =
                                    await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.custom,
                                  allowedExtensions: ['png', 'jpg', 'heic'],
                                );
                                if (results == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('No file selected')),
                                  );
                                  return null;
                                }

                                final path = results.files.single.path!;
                                final filename = results.files.single.name;

                                storage
                                    .uploadFile(path, filename)
                                    .then((downloadURL) {
                                  if (downloadURL != null) {
                                    setState(() {
                                      imageUrl = downloadURL;
                                    });
                                    print(
                                        '            d        d       d $imageUrl'); // Print the imageUrl inside the callback
                                  } else {
                                    print('Upload failed.');
                                  }
                                });
                              },
                              child: Text('Post'),
                            ),
                          ],
                        ),
                      ),
                      // Text('Select your location'),
                      SizedBox(height: 14.0),

                      // TextButton(
                      //     onPressed: () {
                      //       // Navigate to the MapSample screen using GetX
                      //       Get.to(() => blood()); // Use the builder function
                      //       lat = lt!;
                      //     },
                      //     child: Text('Blood Group')),

                      _isProcessing
                          ? CircularProgressIndicator()
                          : Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _isProcessing = true;
                                      });

                                      if (_registerFormKey.currentState!
                                          .validate()) {
                                        User? user = await FirebaseAuthHelper
                                            .registerUsingEmailPassword(
                                          name: controller
                                              .nameTextController.text,
                                          email: controller
                                              .emailTextController.text,
                                          password: controller
                                              .passwordTextController.text,
                                        );
                                        us = user;
                                        controller.Cuser1=us!;
                                        //LatLng lat=LatLng(0, 0);
                                        lat = controller.lt;
                                        bl = controller.Blood.text;
                                        if (bl == null) {
                                          bl = '01';
                                        }
                                        try {
                                          yoo = await fetchUserIds();
                                          print(yoo);
                                          print('daddjakjwakndajdandkamdkaj');
                                          //controller.people=yoo;
                                          await controller.peopleTodoner();
                                          print('jdamadmadnkanda');
                                          print(controller.items.length);
                                        } catch (e) {
                                          print('ERROR:$e');
                                          //print(imageUrl);
                                        }
                                        controller.name =
                                            controller.nameTextController.text;

                                        try {
                                          storeData(
                                              'users',
                                              controller
                                                  .nameTextController.text,
                                              user!.uid,
                                              controller
                                                  .emailTextController.text,
                                              controller
                                                  .passwordTextController.text,
                                              lat,
                                              bl,
                                              yoo,
                                              imageUrl!);
                                          print('fkakddamd');
                                        } catch (e) {
                                          print('Error getting it: $e');
                                        }
                                        controller.Cuser =
                                            controller.nameTextController.text;
                                        controller.CuserPic =
                                            'images/flutter.png';
                                        setState(() {
                                          _isProcessing = false;
                                        });

                                        if (user != null) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(user: user),
                                            ),
                                            ModalRoute.withName('/'),
                                          );
                                        }
                                      } else {
                                        setState(() {
                                          _isProcessing = false;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ))),
                                    // style: ButtonStyle(
                                    //   backgroundColor:
                                    //       MaterialStateProperty.all(
                                    //           Color.fromARGB(255, 4, 118, 124)),
                                    // ),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

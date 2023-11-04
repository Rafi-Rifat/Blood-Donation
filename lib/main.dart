import 'package:auth_app/Databases/makePostList.dart';
import 'package:auth_app/begening.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Databases/MakeUserList.dart';
import 'GET/controller.dart';
import 'screens/splash_screen.dart';

void main() async {
  final controller = Get.put(Controller());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;

  // If a user is authenticated, set the user's ID in your controller
  if (user != null) {
    await inti(user);
  }
  // try {
  //   CollectionReference usersCollection =
  //       FirebaseFirestore.instance.collection('users');
  //   QuerySnapshot querySnapshot = await usersCollection
  //       .where('userId', isEqualTo: controller.CusID)
  //       .get();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     DocumentSnapshot document = querySnapshot.docs.first;
  //     Map<String, dynamic> userData =
  //         (await document.data()) as Map<String, dynamic>;
  //     controller.lt = LatLng(userData['lat'], userData['lang']);
  //     controller.name = userData['name'];
  //     //print(
  //       //  'post                           post                            posy');
  //     if (userData['ChatPerson'] != null) {
  //       controller.ChatPerson = List<String>.from(userData['ChatPerson']);
  //     }
  //
  //     if (userData['image'] != null) {
  //       controller.img = userData['image'];
  //     }
  //     //print(
  //       //  'post                           post                            posy');
  //     await controller.peopleTodoner1();
  //     controller.post = await PostIds(controller.CusID);
  //     //print(
  //       //  'post                           post                            posy');
  //     print(controller.post.length);
  //     //print(controller.post[0].second.);
  //   }
  // } catch (e) {
  //   print('ERROR:$e');
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'blood donation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 24.0,
            ),
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          ),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 46.0,
            color: Colors.blue.shade700,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: const TextStyle(fontSize: 18.0),
        ),
      ),
      home: const SplashScreen(), // Use SplashScreen as the home widget
    );
  }
}

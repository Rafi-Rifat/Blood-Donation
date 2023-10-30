import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Databases/MakeUserList.dart';
import 'GET/controller.dart';
import 'screens/splash_screen.dart';

void main() async {
  final controller =Get.put(Controller());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;

  // If a user is authenticated, set the user's ID in your controller
  if (user != null) {
    controller.CusID = user.uid;
    controller.Cuser1=user;
  }
  try{
    //controller.people=await fetchUserIds();
    //print(yoo);
    print('daddjakjwakndajdandkamdkaj');
    //controller.people=yoo;
    await controller.peopleTodoner();
    // print('jdamadmadnkanda');
    // print(controller.items.length);
  }catch(e){
    print('ERROR:$e');
  }
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

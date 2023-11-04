import 'package:auth_app/GET/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Databases/makePostList.dart';

Future<void> inti(User user) async {
  final Controller controller=Get.find();
  controller.CusID = user.uid;
  controller.Cuser1 = user;
  try {
    CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await usersCollection
        .where('userId', isEqualTo: controller.CusID)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot document = querySnapshot.docs.first;
      Map<String, dynamic> userData =
      (await document.data()) as Map<String, dynamic>;
  controller.lt = LatLng(userData['lat'], userData['lang']);
  controller.name = userData['name'];
  //print(
  //  'post                           post                            posy');
  if (userData['ChatPerson'] != null) {
    controller.ChatPerson=[];
  controller.ChatPerson = List<String>.from(userData['ChatPerson']);
  print(controller.ChatPerson);
  }

  if (userData['image'] != null) {
  controller.img = userData['image'];
  }
  //print(
  //  'post                           post                            posy');
  await controller.peopleTodoner1();
  controller.post = await PostIds(controller.CusID);
  //print(
  //  'post                           post                            posy');
  print(controller.post.length);
  controller.people=[];
  //controller.ChatPerson=[];

  //print(controller.post[0].second.);
  }
  } catch (e) {
  print('ERROR:$e');
  }
}
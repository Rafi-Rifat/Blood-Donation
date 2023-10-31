import 'dart:core';
import 'dart:ffi';

import 'package:auth_app/Databases/TakeData.dart';
import 'package:auth_app/Doner/doner.dart';
import 'package:auth_app/Work/DonerData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Work/PostData.dart';
import '../Work/Tree.dart';

class Controller extends GetxController {
  late TextEditingController nameTextController = TextEditingController();
  late TextEditingController emailTextController = TextEditingController();
  late TextEditingController passwordTextController = TextEditingController();
  late TextEditingController Blood = TextEditingController();
  late TextEditingController BRequest = TextEditingController();

  late String Cuser;
  late String CuserPic;
  late String CusID = '';
  late String name = ' ';
  String img =
      'https://img.freepik.com/premium-vector/accoun-vector-icon-with-long-shadow-white-illustration-isolated-blue-round-background-graphic-web-design_549897-771.jpg';
  int homeIndex = 0;
  late User Cuser1;
  List<String> ChatPerson = [];

  LatLng lt = LatLng(0, 0);
  LatLng ForFindDoner = LatLng(0, 0);
  List<Pair<double, postData>> post = [];
  List<String> postseen = [];
  // late List<Widget> dn;
  //
  // void addD(String pic,String name){
  //   dn.add(doner(pic: pic, name: name,
  //       onTap:(){
  //
  //       }
  //   ));
  bool pu = false;
  List<DonerData> items = [];
  List<DonerData> items1 = [];

  List<Pair<Pair<String, String>, double>> people = [];
  List<Pair<String, double>> people1 = [];

  late List<String> ogochalo;

  get selectedBloodGroup => null;
  Future<void> peopleTodoner() async {
    if (items.length != 0) {
      items.removeRange(0, items.length);
    }

    try {
      late Map<String, dynamic> userData;
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      //int l=people.length;
      //print('SIZE: $l');
      for (var l in people) {
        //print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
        String uid = l.first.first;
        //print(uid);
        double pil = l.second;
        //print(pil);
        //print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
        QuerySnapshot querySnapshot = await usersCollection
            .where('userId', isEqualTo: l.first.first)
            .get();
        print(
            'hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot document = querySnapshot.docs.first;
          userData = (await document.data()) as Map<String, dynamic>;
        }

        String name = userData['name'];
        LatLng lt = LatLng(userData['lat'], userData['lang']);
        String em = userData['email'];
        String bl = userData['bl'];
        String img = 'images/blood.jpg';
        if (userData['image'] != null) {
          img = userData['image'];
        }
        DonerData d = DonerData(uid, name, lt, em, bl, img);
        items.add(d);
      }
      print(
          'hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
    } catch (e) {
      print('ERROR $e');
    }
    //late List<String> chat;
  }

  Future<void> peopleTodoner1() async {
    if (items1.length != 0) {
      items1.removeRange(0, items1.length);
    }

    try {
      //late Map<String, dynamic> userData;
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      //int l=people.length;
      int l = ChatPerson.length;
      print('SIZE: $l');
      for (int i = 0; i < ChatPerson.length; i++) {
        var l = ChatPerson[i];
        //print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
        String uid = l;
        print(l);
        //print(uid);
        //double pil=l.second;
        //print(pil);
        //print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
        QuerySnapshot querySnapshot =
            await usersCollection.where('userId', isEqualTo: uid).get();
        print(querySnapshot.docs.isNotEmpty);
        // print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
        if (querySnapshot.docs.isNotEmpty) {
          print(
              'hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
          DocumentSnapshot document = querySnapshot.docs.first;
          Map<String, dynamic> userData =
              (await document.data()) as Map<String, dynamic>;

          String name = userData['name'];
          LatLng lt = LatLng(userData['lat'], userData['lang']);
          print(name);
          print(uid);
          String em = userData['email'];
          String bl = userData['bl'];
          String img = 'images/blood.jpg';
          //DonerData d = DonerData(uid, name,lt,em,bl);
          if (userData['image'] != null) {
            img = userData['image'];
          }
          DonerData d = DonerData(uid, name, lt, em, bl, img);
          items1.add(d);
        }

        // String name = userData['name'];
        // DonerData d = DonerData(uid, name);
        // items1.add(d);
      }
      int l1 = items1.length;
      print(l1);
      //print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
    } catch (e) {
      print('ERROR putki $e');
    }
    //late List<String> chat;
  }

  Future<void> fetchChatPerson() async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnapshot =
          await usersCollection.where('userId', isEqualTo: CusID).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        Map<String, dynamic> userData =
            (await document.data()) as Map<String, dynamic>;
        ChatPerson = List<String>.from(userData['ChatPerson']);

        //DonerData d=DonerData(l, name);
        //items1.insert(0,d);
      }
    } catch (e) {
      print('ERROR: in Chatperson $e');
    }
  }

  Future<void> ChangeChatListWhenTheChatIsNew(String l) async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnapshot =
          await usersCollection.where('userId', isEqualTo: l).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        Map<String, dynamic> userData =
            (await document.data()) as Map<String, dynamic>;
        String name = userData['name'];
        LatLng lt = LatLng(userData['lat'], userData['lang']);
        String em = userData['email'];
        String bl = userData['bl'];
        //DonerData d=DonerData(l,name,lt,em,bl);
        String img = 'images/blood.jpg';
        //DonerData d = DonerData(uid, name,lt,em,bl);
        if (userData['image'] != null) {
          img = userData['image'];
        }
        DonerData d = DonerData(l, name, lt, em, bl, img);
        items1.insert(0, d);
      }
    } catch (e) {}
  }

  late List<String> chat;
  List<String> NeedToAdd = [];
}

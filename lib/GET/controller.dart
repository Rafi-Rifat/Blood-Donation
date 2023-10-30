import 'dart:core';


import 'package:auth_app/Databases/TakeData.dart';
import 'package:auth_app/Doner/doner.dart';
import 'package:auth_app/Work/DonerData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Work/Tree.dart';

class Controller extends GetxController{
  late TextEditingController nameTextController = TextEditingController();
  late TextEditingController emailTextController = TextEditingController();
  late TextEditingController passwordTextController = TextEditingController();
  late TextEditingController Blood = TextEditingController();
  late TextEditingController BRequest=TextEditingController();

  late String Cuser;
  late String CuserPic;
  late String CusID='';
  int homeIndex=0;
  late User Cuser1;
  List<String> ChatPerson=[];

  LatLng lt=LatLng(0, 0);
  LatLng ForFindDoner=LatLng(0, 0);
  // late List<Widget> dn;
  //
  // void addD(String pic,String name){
  //   dn.add(doner(pic: pic, name: name,
  //       onTap:(){
  //
  //       }
  //   ));
  bool pu=false;
   List<DonerData> items=[];
  List<DonerData> items1=[];

  List<Pair<Pair<String,String>,double>> people=[];

  late List<String> ogochalo;

  get selectedBloodGroup => null;
  Future<void> peopleTodoner() async {

      if(items.length!=0){
        items.removeRange(0, items.length-1);
      }

      try {
        late Map<String, dynamic> userData;
        CollectionReference usersCollection = FirebaseFirestore.instance
            .collection('users');
        //int l=people.length;
        //print('SIZE: $l');
         for (var l in people) {
          //print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
          String uid = l.first.first;
          //print(uid);
          double pil=l.second;
          //print(pil);
          //print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
          QuerySnapshot querySnapshot = await usersCollection.where('userId', isEqualTo: l.first.first).get();
          print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
          if (querySnapshot.docs.isNotEmpty) {
            DocumentSnapshot document = querySnapshot.docs.first;
             userData = (await document.data()) as Map<
                String,
                dynamic>;
          }

          String name = userData['name'];
          DonerData d = DonerData(uid, name);
          items.add(d);
        }
        print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
      }catch(e){
        print('ERROR $e');
      }
  //late List<String> chat;

  }
  Future<void> peopleTodoner1() async {

    if(items1.length!=0){
      items1.removeRange(0, items1.length-1);
    }

    try {
      //late Map<String, dynamic> userData;
      CollectionReference usersCollection = FirebaseFirestore.instance
          .collection('users');
      //int l=people.length;
      //print('SIZE: $l');
      for (int i=0;i<ChatPerson.length;i++) {
        var l=ChatPerson[i];
        //print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
        String uid = l;
        //print(uid);
        //double pil=l.second;
        //print(pil);
        //print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
        QuerySnapshot querySnapshot = await usersCollection.where('userId', isEqualTo: uid).get();
        print(querySnapshot.docs.isNotEmpty);
        // print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
        if (querySnapshot.docs.isNotEmpty) {
          print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
          DocumentSnapshot document = querySnapshot.docs.first;
          Map<
              String,
              dynamic> userData = (await document.data()) as Map<
              String,
              dynamic>;

          String name = userData['name'];
          print(name);
          print(uid);
          DonerData d = DonerData(uid, name);
          items1.add(d);
        }

        // String name = userData['name'];
        // DonerData d = DonerData(uid, name);
        // items1.add(d);
      }
      //print('hhhhhhhhhh                hhhhhhhhhhhh               hhhhhhhhhhhhh           hhhhhhh');
    }catch(e){
      print('ERROR putki $e');
    }
    //late List<String> chat;

  }
  Future<void> ChangeChatListWhenTheChatIsNew(String l) async {

    try{
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      QuerySnapshot querySnapshot = await usersCollection.where('userId', isEqualTo: l).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        Map<
            String,
            dynamic> userData = (await document.data()) as Map<
            String,
            dynamic>;
        String name=userData['name'];
        DonerData d=DonerData(l, name);
        items1.insert(0,d);
      }


    }catch(e){

    }
  }
  late List<String> chat;
  List<String> NeedToAdd=[];
}
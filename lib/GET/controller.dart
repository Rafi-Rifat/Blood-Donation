import 'dart:core';


import 'package:auth_app/Databases/TakeData.dart';
import 'package:auth_app/Doner/doner.dart';
import 'package:auth_app/Work/DonerData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  late String CusID;

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

   List<Pair<String,double>> people=[];

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
        int l=people.length;
        print('SIZE: $l');
        for (var l in people) {
          String uid = l.first;
          //print(uid);
          double pil=l.second;
          //print(pil);

          QuerySnapshot querySnapshot = await usersCollection.where(
              'userId', isEqualTo: l.first).get();
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
      }catch(e){
        print('ERROR $e');
      }
  //late List<String> chat;

  }
  late List<String> chat;
}
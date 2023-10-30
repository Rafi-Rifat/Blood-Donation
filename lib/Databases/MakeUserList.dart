import 'package:auth_app/GET/controller.dart';
//import 'package:auth_app/Work/Calculate%20distance.dart'; // Make sure to import the correct file
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Work/Calulate distance.dart';
import '../Work/Tree.dart';

Future<List<Pair<String, double>>> fetchUserIds() async {
  List<Pair<String, double>> userIds = [];

  try {
    final Controller cont = Get.find();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      String userId = doc.id;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      double dis = calculateDistance(cont.lt.latitude, cont.lt.longitude, data['lat'], data['lang']);
      userIds.add(Pair(userId, dis));
    }
    userIds.sort((a, b) => a.second.compareTo(b.second));
  } catch (e) {
    print('Error fetching user IDs: $e');
  }

  return userIds;
}

Future<List<Pair<Pair<String,String>,double>>> fetchUserIds1(String Group) async {
  List<Pair<Pair<String,String>,double>> userIds = [];
  List<Pair<Pair<String,String>,double>> userIds1 = [];

  try {
    print(Group);
    final Controller cont = Get.find();
    int count=0;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {

      String userId = doc.id;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      print('ndkandkandkandka sn fdkandka kd akn dka dma md ');
      double dis=1000000000;
      if(data['lat']!=null||data['lang']!=null){
         dis= calculateDistance(cont.lt.latitude, cont.lt.longitude, data['lat'], data['lang']);
      }
      print('ndkandkandkandka sn fdkandka kd akn dka dma md 22222222222222222222');
      String bl='';
      if(data['bl']!=null){
        bl=data['bl'];
      }
      print('ndkandkandkandka sn fdkandka kd akn dka dma md 33333333333333333333333333333');
      userIds.add(Pair(Pair(userId,bl), dis));
      count++;
    }
    print('ndkandkandkandka sn fdkandka kd akn dka dma md 55555555555555555555555555');
    userIds.sort((a, b) => a.second.compareTo(b.second));
    print('ndkandkandkandka sn fdkandka kd akn dka dma md 44444444444444');

    print('ndkandkandkandka sn fdkandka kd akn dka dma md ');
    print(userIds.length);
    count=0;
    for(int i=0;i<userIds.length;i++){
      print('yooooooo               yooooooooooooooo            yo         yo $count');
      if(count>6)break;
      print(userIds[i].first.second);
      if(userIds[i].first.second==Group){
        userIds1.add(userIds[i]);
        count++;
      }
    }

  } catch (e) {
    print('Error fetching user IDs HHHHHHHHHHHHH: $e');
  }

  return userIds1;
}

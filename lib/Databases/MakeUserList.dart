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

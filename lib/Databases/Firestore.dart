import 'package:auth_app/Databases/TakeData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Work/Tree.dart';

Future<void> storeData(String usersCollection, String name, String userId,String email,String password,LatLng lt,String bl,List<Pair<String,double>> peo,String img) async {
  try {
    List<Map<String, dynamic>> peoList = peo.map((pair) {
      return {
        'first': pair.first,
        'second': pair.second,
      };
    }).toList();
    // Get a reference to the Firestore collection
    CollectionReference store = FirebaseFirestore.instance.collection(usersCollection);
    print('putki');

    // Use the provided `userId` as the document ID
    List<String>pl=[];
    pl.add('1');
    List<String> post=[];

    await store.doc(userId).set({
      'name': name,
      'email':email,
      'pass':password,
      'lat':lt.latitude,
      'lang':lt.longitude,
      'userId':userId,
      'bl':bl,
      'people':peoList,
      'NeedToAdd':pl,
      'PostSeen':post,
      'image':img


    });
    print('fjd');

    print('Data stored successfully!');
  } catch (e) {
    print('Error storing data: $e');
  }
}


void storeDataFriendList(List<String> items,String userId) async {
  try {
    // Reference to the Firestore document where you want to store the list
    DocumentReference docRef = FirebaseFirestore.instance.collection('user').doc(userId);

    // Set the document with the list field
    await docRef.set({
      'Friend': items,
    });

    //print('Data stored successfully!');
  } catch (e) {
    print('Error storing data: $e');
  }
}

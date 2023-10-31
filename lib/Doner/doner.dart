import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/screens/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Work/DonerData.dart';
import '../helper/mapFor Find.dart';

class DonorCard extends StatelessWidget {
  final DonerData donerData;
  final int index;

  DonorCard({required this.donerData, required this.index});

  @override
  Widget build(BuildContext context) {
    final Controller cont=Get.find();
    return Card(
      child: ListTile(
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(donerData.img),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CircleAvatar(
                backgroundColor: donerData.IsOnline ? Colors.green : Colors.red,
                radius: 5,
              ),
            ),
          ],
        ),
        title: Text(
          donerData.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            LatLng lt=donerData.DonerLatLang;
            Get.to(()=>Mapfor(lt: lt));
          },
          child: Text('Button Text'),
        ),
        onTap: () async {
          String Fid=donerData.Uid;
          List<String> chat=[];
          List<String> massage = [];
          try {
            print(cont.CusID);
            print(Fid);
            CollectionReference usersCollection = FirebaseFirestore.instance.collection('users').doc(cont.CusID).collection('chat');
            QuerySnapshot querySnapshot = await usersCollection.where('chatid', isEqualTo: Fid).get();

            List<String> massage = [];

            bool p=querySnapshot.docs.isNotEmpty;// Initialize massage as an empty list

            print('IS NULL $p');

            if (querySnapshot.docs.isNotEmpty) {
              // There should be only one document with a matching user ID
              DocumentSnapshot document = querySnapshot.docs.first;
              // Access document data using document.data() as a Map
              Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
              if (userData.containsKey('chat')) {
                massage = List<String>.from(userData['chat']);
              }
              cont.chat = massage;
            }

            Get.to(() => ChatScreen(FId: Fid, don: donerData, mass: massage,index: index,));
          } catch (e) {
            print('ERROR: $e');
          }


          //Get.to(() => ChatScreen(FId: Fid , don: donerData,mass: massage,));
        },
      ),
    );
  }
}

import 'package:auth_app/Work/DonerData.dart';
import 'package:auth_app/Work/PostData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../GET/controller.dart';
import 'Chat.dart';

class PostCard extends StatefulWidget {
  final postData pos;

  const PostCard({Key? key, required this.pos}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    final Controller cont = Get.find();

    return GestureDetector(
      onTap: () async {
        // Handle onTap action here.
        // You can navigate to a new page or show more details, for example.
        String Fid = widget.pos.userId;
        List<String> chat = [];
        List<String> massage = [];
        try {
          print(cont.CusID);
          print(Fid);
          CollectionReference usersCollection = FirebaseFirestore.instance
              .collection('users')
              .doc(cont.CusID)
              .collection('chat');
          QuerySnapshot querySnapshot =
          await usersCollection.where('chatid', isEqualTo: Fid).get();

          List<String> massage = [];

          bool p = querySnapshot.docs.isNotEmpty; // Initialize massage as an empty list

          print('IS NULL $p');

          if (querySnapshot.docs.isNotEmpty) {
            DocumentSnapshot document = querySnapshot.docs.first;
            Map<String, dynamic> userData =
            document.data() as Map<String, dynamic>;
            if (userData.containsKey('chat')) {
              massage = List<String>.from(userData['chat']);
            }
            cont.chat = massage;
          }
          late Map<String, dynamic> userData;
          try {
            CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');
            QuerySnapshot querySnapshot = await usersCollection
                .where('userId', isEqualTo: widget.pos.userId)
                .get();
            if (querySnapshot.docs.isNotEmpty) {
              DocumentSnapshot document = querySnapshot.docs.first;
              userData = (await document.data()) as Map<String, dynamic>;
            }
          } catch (e) {}

          String Uid = userData['userId'];
          String name = userData['name'];
          LatLng d = LatLng(userData['lat'], userData['lang']);
          String email = userData['email'];
          String bl = userData['bl'];
          String img = widget.pos.image;
          DonerData don = DonerData(Uid, name, d, email, bl, img);
          int index = 0;

          Get.to(() => ChatScreen(
            FId: Fid,
            don: don,
            mass: massage,
            index: index,
          ));
        } catch (e) {
          print('ERROR: $e');
        }
      },
      child: Card(
        color: Colors.white, // Background color
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(
                      widget.pos.image,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    widget.pos.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                widget.pos.date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.pos.postText,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

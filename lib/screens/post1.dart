import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/Work/DonerData.dart';
import 'package:auth_app/Work/PostData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Chat.dart';

class PostCard extends StatefulWidget {
  final postData pos;

  const PostCard({Key? key, required this.pos}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  int likeCount = 0;
  bool isCommented = false;

  //get donerData => null;

  @override
  Widget build(BuildContext context) {
    final Controller cont=Get.find();
    return GestureDetector(
      onTap:() async {
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

          bool p = querySnapshot
              .docs.isNotEmpty; // Initialize massage as an empty list

          print('IS NULL $p');

          if (querySnapshot.docs.isNotEmpty) {
            // There should be only one document with a matching user ID
            DocumentSnapshot document = querySnapshot.docs.first;
            // Access document data using document.data() as a Map
            Map<String, dynamic> userData =
            document.data() as Map<String, dynamic>;
            if (userData.containsKey('chat')) {
              massage = List<String>.from(userData['chat']);
            }
            cont.chat = massage;
          }
          late DonerData d;
          late Map<String, dynamic> userData;
          try{
            CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');
            QuerySnapshot querySnapshot = await usersCollection.where('userId', isEqualTo: widget.pos.userId).get();
            if (querySnapshot.docs.isNotEmpty) {
              DocumentSnapshot document = querySnapshot.docs.first;
              userData = (await document.data()) as Map<String, dynamic>;

              // String name=userData['name'];
              // LatLng lt=LatLng(userData['lat'], userData['lang']);
              // String email=userData['email'];
              // String bl=userData['bl'];
              // String img='https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
              // if(userData['Image']!=null){
              //   img=userData['Image'];
              // }
              //
              // d= await DonerData(widget.pos.userId, name, lt, email, bl, img);
            }
          }catch(e){
           print('ERROR IN POST1');
          }
          int index=0;
          String name=userData['name'];
          LatLng lt=LatLng(userData['lat'], userData['lang']);
          String email=userData['email'];
          String bl=userData['bl'];
          String img=widget.pos.image;
          print(img);
          if(userData['Image']!=null){
            img=userData['Image'];
          }
          
          print(img);

          d= await DonerData(widget.pos.userId, name, lt, email, bl, img);

          Get.to(() => ChatScreen(
            FId: Fid,
            don: d,
            mass: massage,
            index: index,
          ));
        } catch (e) {
          print('ERROR: $e');
        }

      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(widget.pos.image),
                      ),
                      Text(
                        widget.pos.date,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.pos.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.pos.postText,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

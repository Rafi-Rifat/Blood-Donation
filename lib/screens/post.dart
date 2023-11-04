import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/screens/home_screen.dart';
import 'package:auth_app/screens/post1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart'; // Import the liquid_pull_to_refresh package

import '../Databases/makePostList.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  final Controller cont = Get.find();
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh( // Wrap your content with LiquidPullToRefresh
      onRefresh: () async {
        cont.post = await PostIds(cont.CusID);
        setState(() {

        });

      },
      height: 200,
      backgroundColor: Color.fromARGB(255, 14, 146, 235),
      animSpeedFactor: 1,


      color: Color.fromARGB(255, 255, 255, 255), // Set the color of the refresh indicator.
      showChildOpacityTransition: true, // Optional: Set to true to show a fade transition for the refreshed content.
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                // Your existing code for the list view
                padding: EdgeInsets.symmetric(horizontal: 16),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: cont.post.length,
                itemBuilder: (context, index) {
                  int leg = cont.items.length;
                  //print('niganiga dbajhdahdjjandjabndkkankdan $leg');
                  return PostCard(pos: cont.post[index].second);
                },
                physics: const BouncingScrollPhysics(),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey[200], // Highlight color
                ),
                child: TextField(
                  controller: _textFieldController,
                  decoration: InputDecoration(
                    hintText: 'Enter your data',
                    border: InputBorder.none, // Remove border
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await _addDataToFirestore(_textFieldController.text);
                _textFieldController.clear();
              },
              child: const Text('post '),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),

                // Change the text color
                foregroundColor: MaterialStateProperty.all(Colors.white),

                // Change the button's elevation
                elevation: MaterialStateProperty.all(2.0),

                // Adjust the padding of the button
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 25, vertical: 5)),

                // Apply a custom shape to the button
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addDataToFirestore(String data) async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection('post')
        .add({
      'name': cont.name,
      'data': data,
      'TimeStamp': FieldValue.serverTimestamp(),
      'userId': cont.CusID,
      'lat': cont.lt.latitude,
      'lang': cont.lt.longitude,
      'Image':cont.img
    });
    String docId = documentReference.id;
    DocumentReference docRef =
    FirebaseFirestore.instance.collection('post').doc(docId);
    docRef.set({'postId': docId}, SetOptions(merge: true));

    print(cont.post.length);
    cont.post = await PostIds(cont.CusID);
    print(cont.post.length);
    cont.homeIndex = 0;
    Get.to(() => HomeScreen(
      user: cont.Cuser1,
    ));
  }

  Future<void> _deleteDataFromFirestore(String documentId) async {
    await FirebaseFirestore.instance
        .collection('user_data')
        .doc(documentId)
        .delete();
  }
}

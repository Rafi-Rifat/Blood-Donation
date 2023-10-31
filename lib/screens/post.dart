import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/screens/post1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Databases/makePostList.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  final Controller cont=Get.find();
  final TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (context, index) =>
              const SizedBox(height: 10,),
              itemCount: cont.post.length,
              itemBuilder: (context, index)  {
                int leg=cont.items.length;
                print('niganiga dbajhdahdjjandjabndkkankdan $leg');
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
              backgroundColor: MaterialStateProperty.all(Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _addDataToFirestore(String data) async {
    DocumentReference documentReference = await FirebaseFirestore.instance.collection('post').add({
      'name': cont.name,
      'data': data,
      'TimeStamp': FieldValue.serverTimestamp(),
      'userId':cont.CusID,
      'lat':cont.lt.latitude,
      'lang':cont.lt.longitude

    });
    String docId = documentReference.id;
    DocumentReference docRef = FirebaseFirestore.instance.collection('post').doc(docId);
    docRef.set({
      'postId':docId
    },SetOptions(merge: true));
    //cont.post=await PostIds(cont.CusID);
    setState(() async{
      print(cont.post.length);
      cont.post=await PostIds(cont.CusID);
      print(cont.post.length);
    });

  }

  Future<void> _deleteDataFromFirestore(String documentId) async {
    await FirebaseFirestore.instance.collection('user_data').doc(documentId).delete();
  }

}

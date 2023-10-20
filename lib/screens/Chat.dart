import 'package:auth_app/Chat1/CDOC.dart';
import 'package:auth_app/Chat1/ChatTextt.dart';
import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/Work/DonerData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key,  required this.FId, required this.don, required this.mass});
  //final String UserId;
  final String FId;
  final DonerData don;
  final List<String> mass;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Controller cont=Get.find();
  List<String> messages = []; // List to store chat messages
  List<String> massageforhim=[];
  final TextEditingController messageController = TextEditingController();
   late String Token=cont.CusID;
   bool kul=false;

   void makekul(){
     kul=true;
   }

  void initState() {
    super.initState();
    messages = List.from(widget.mass);
    massageforhim=List.from(widget.mass);// Initialize messages in initState

  }

  // Function to send a message
  Future<void> sendMessage(String message) async {
    //messages.add(message);
    print(message.length);
    setState(()  {
      messages.add('1');
      messages.add(message);
      massageforhim.add(message);


      messageController.clear();
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              //reverse: true,

              itemBuilder: (context, index) {
                String dd='';
                print(' I AM GANDU');
                print(widget.mass.length);

                bool ali=false;
                //  String sp='';
                if(messages[index]=='1'){

                  makekul();
                  return pad();
                }
                else {
                  dd=messages[index];
                }
                ali=kul;
                kul=false;
                print(index);
                print(ali);
                return Align(
                    alignment:Alignment.centerRight,
                    child: ChatText(don: widget.don, SP: dd, alignment: ali)
                );


              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(labelText: 'Type a message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {

                    try{
                      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users').doc(widget.FId).collection('chat');
                      QuerySnapshot querySnapshot = await usersCollection.where('chatid', isEqualTo: cont.CusID).get();

                      if (querySnapshot.docs.isNotEmpty) {
                        // There should be only one document with a matching user ID
                        DocumentSnapshot document = querySnapshot.docs.first;
                        // Access document data using document.data() as a Map
                        Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
                        if (userData.containsKey('chat')) {
                          massageforhim = List<String>.from(userData['chat']);
                        }
                        //cont.chat = massage;
                      }

                    }catch(e){

                    }

                    String message = messageController.text;
                    if (message.isNotEmpty) {
                      sendMessage(message);

                    }
                    try{
                      print('hghihkhugujbjb');
                      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users').doc(cont.CusID).collection('chat');
                      await usersCollection.doc(widget.FId).set({
                        'chat':messages,
                        'chatid':widget.FId
                      });
                    }catch(e){
                      print('ERROR $e');
                    }
                    try{
                      print('hghihkhugujbjb');
                      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users').doc(widget.FId).collection('chat');
                      await usersCollection.doc(cont.CusID).set({
                        'chat':massageforhim,
                        'chatid':cont.CusID
                      });
                    }catch(e){
                      print('ERROR $e');
                    }

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
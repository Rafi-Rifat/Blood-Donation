import 'package:auth_app/Chat1/CDOC.dart';
import 'package:auth_app/Chat1/ChatTextt.dart';
import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/Work/DonerData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
      {super.key,
        required this.FId,
        required this.don,
        required this.mass,
        required this.index});
  //final String UserId;
  final String FId;
  final DonerData don;
  final List<String> mass;
  final int index;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Controller cont = Get.find();
  List<String> messages = []; // List to store chat messages
  List<String> massageforhim = [];
  late int ChatCardIndex;
  final TextEditingController messageController = TextEditingController();
  late String Token = cont.CusID;
  bool kul = false;
  String image='images/blood.jpg';

  void makekul() {
    kul = true;
  }

  void initState() {
    super.initState();
    messages = List.from(widget.mass);
    massageforhim = List.from(widget.mass); // Initialize messages in initState
    ChatCardIndex = widget.index;
    // if(widget.don.img!=null){
    //   image=widget.don.img;
    // }

  }

  // Function to send a message
  Future<void> sendMessage(String message) async {
    //messages.add(message);
    print(messages);
    print(cont.items1.length);
    if (messages.length == 0) {
      print('success1111111111111111');
      Map<String, dynamic> userData;

      try {
        CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
        QuerySnapshot querySnapshot =
        await usersCollection.where('userId', isEqualTo: cont.CusID).get();

        //print('success 22222222222222');
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot document = querySnapshot.docs.first;
          userData = (await document.data()) as Map<String, dynamic>;
          //print('success 33333333333333');
          List<String> ChatPerson = [];
          if (userData['ChatPerson'] != null) {
            //print('success 444444444444444');
            ChatPerson = List<String>.from(userData['ChatPerson']);
            //print('success 55555555555555555555');
          }
          ChatPerson.insert(0, widget.FId);

          cont.ChatPerson = ChatPerson;
          await cont.ChangeChatListWhenTheChatIsNew(widget.FId);
          print('alu                                    alu                        alu' );
          await usersCollection
              .doc(cont.CusID)
              .set({'ChatPerson': ChatPerson}, SetOptions(merge: true));
        }

        try {
          CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
          QuerySnapshot querySnapshot = await usersCollection
              .where('userId', isEqualTo: widget.FId)
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            DocumentSnapshot document = querySnapshot.docs.first;
            Map<String, dynamic> userData =
            (await document.data()) as Map<String, dynamic>;
            if (userData['NeedToAdd'] != null) {
              List<String> pl = List<String>.from(userData['NeedToAdd']);
              if (pl.length == 1 && pl[0] == '1') {
                pl.removeAt(0);
                pl.insert(0, cont.CusID);
              } else {
                int fq = pl.indexOf(cont.CusID);
                print(fq);
                print(pl);
                if (fq == -1) {
                  pl.insert(0, cont.CusID);
                } else {
                  pl.removeAt(fq);
                  pl.add(cont.CusID);
                }
                print(pl);
              }
              await usersCollection
                  .doc(widget.FId)
                  .set({'NeedToAdd': pl}, SetOptions(merge: true));
            }
          }
        } catch (e) {
          print('Chat At the time of NeedToAdd $e');
        }
        //List<String> ChatPerson=userData['ChatPerson'];
      } catch (e) {
        print('Error fetching user data1: $e');
        throw e;
      }
    }
    //print('Chat c I $ChatCardIndex');
    else if (ChatCardIndex != 0 && cont.items1.length != 0) {
      String l = cont.ChatPerson[ChatCardIndex];
      cont.ChatPerson.removeAt(ChatCardIndex);
      cont.ChatPerson.insert(0, l);
      DonerData d = cont.items1[ChatCardIndex];
      cont.items1.removeAt(ChatCardIndex);

      cont.items1.insert(0, d);
      print('dNeed             needn                  need');
      try {
        CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
        QuerySnapshot querySnapshot =
        await usersCollection.where('userId', isEqualTo: widget.FId).get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot document = querySnapshot.docs.first;
          Map<String, dynamic> userData =
          (await document.data()) as Map<String, dynamic>;
          if (userData['NeedToAdd'] != null) {
            List<String> pl = List<String>.from(userData['NeedToAdd']);
            if (pl.length == 1 && pl[0] == '1') {
              pl.removeAt(0);
              pl.insert(0, cont.CusID);
            } else {
              int fq = pl.indexOf(cont.CusID);
              print(fq);
              print(pl);
              if (fq == -1) {
                pl.insert(0, cont.CusID);
              } else {
                pl.removeAt(fq);
                pl.insert(0, cont.CusID);
              }
              print(pl);
            }
            await usersCollection
                .doc(widget.FId)
                .set({'NeedToAdd': pl}, SetOptions(merge: true));
          }
        }
      } catch (e) {
        print('Chat At the time of NeedToAdd $e');
      }
    }
    print(cont.ChatPerson);
    setState(() {
      messages.add('1');
      messages.add(message);
      massageforhim.add(message);
      print(messages);

      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    String image='images/blood.jpg';

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Chat Screen'),
        leading: GestureDetector(
          onTap: () {
            // Navigate to the profile page when the profile picture is clicked
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage(don: widget.don,)));
          },
          // child: const CircleAvatar(
          //   // Replace with your profile picture image or widget
          //   backgroundImage: NetworkImage(),
          //
          // ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Username',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              //reverse: true,

              itemBuilder: (context, index) {
                String dd = '';
                //print(' I AM GANDU');
                print(widget.mass.length);

                bool ali = false;
                //  String sp='';
                if (messages[index] == '1') {
                  makekul();
                  return pad();
                } else {
                  dd = messages[index];
                }
                ali = kul;
                kul = false;
                //print(index);
                //print(ali);
                return Align(
                    alignment: Alignment.centerRight,
                    child: ChatText(don: widget.don, SP: dd, alignment: ali));
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
                    try {
                      CollectionReference usersCollection = FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(widget.FId)
                          .collection('chat');
                      QuerySnapshot querySnapshot = await usersCollection
                          .where('chatid', isEqualTo: cont.CusID)
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        // There should be only one document with a matching user ID
                        DocumentSnapshot document = querySnapshot.docs.first;
                        // Access document data using document.data() as a Map
                        Map<String, dynamic> userData =
                        document.data() as Map<String, dynamic>;
                        if (userData.containsKey('chat')) {
                          massageforhim = List<String>.from(userData['chat']);
                        }
                        //cont.chat = massage;
                      }
                    } catch (e) {
                      print('ERROR IN CHAT PREESED');
                    }

                    String message = messageController.text;
                    if (message.isNotEmpty) {
                      await sendMessage(message);
                    }
                    try {
                      print('hghihkhugujbjb');
                      CollectionReference usersCollection = FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(cont.CusID)
                          .collection('chat');
                      await usersCollection
                          .doc(widget.FId)
                          .set({'chat': messages, 'chatid': widget.FId});
                    } catch (e) {
                      print('ERROR $e');
                    }
                    try {
                      //print('hghihkhugujbjb');
                      CollectionReference usersCollection = FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(widget.FId)
                          .collection('chat');
                      await usersCollection
                          .doc(cont.CusID)
                          .set({'chat': massageforhim, 'chatid': cont.CusID});
                    } catch (e) {
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
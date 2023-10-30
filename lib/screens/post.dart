import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'home_screen.dart';

class HomeScreen1 extends StatefulWidget {
  final User user;

  HomeScreen1({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
  late User _currentUser;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 209, 187, 213),
        elevation: 0,
        title: Text('HomeScreen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildDataListView(),
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
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Future<void> _addDataToFirestore(String data) async {
    await FirebaseFirestore.instance.collection('user_data').add({
      'email': _currentUser.email,
      'data': data,
      'TimeStamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _deleteDataFromFirestore(String documentId) async {
    await FirebaseFirestore.instance.collection('user_data').doc(documentId).delete();
  }

  Widget _buildDataListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('user_data')
          .where('email', isEqualTo: _currentUser.email)
          .orderBy('TimeStamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          print(snapshot.error);
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Text('No data found.');
        }

        final data = snapshot.data!.docs;

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final email = data[index]['email'];
            final textData = data[index]['data'];
            final timestampValue = data[index]['TimeStamp'];
            final timestamp = timestampValue != null ? (timestampValue as Timestamp).toDate() : DateTime.now();
            final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);

            return Dismissible(
              key: Key(data[index].id),
              onDismissed: (direction) {
                _deleteDataFromFirestore(data[index].id);
              },
              background: Container(
                color: Colors.grey,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              child: Card(
                margin: const EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 5,
                child: ListTile(
                  title: Text(
                    'Email: $email',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 1.0,
                      wordSpacing: 2.0,
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                        wordSpacing: 1.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '$formattedTime: ',
                        ),
                        TextSpan(
                          text: textData,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
//hhh
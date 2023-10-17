import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> storeDataChat(List<String> Chat,String userId,String Friendsid) async {
  try {
    // Get a reference to the Firestore collection
    CollectionReference store = FirebaseFirestore.instance.collection('user').doc(userId).collection('chat');

    CollectionReference store1 = FirebaseFirestore.instance.collection('user').doc(Friendsid).collection('chat');
    
    await store.doc(Friendsid).set({
      'chat':Chat
    }
      
      
    );
    await store1.doc(userId).set(
      {
        'chat':Chat
      }
    );

    // Use the provided `userId` as the document ID
    //Map<String,dynamic> U=getUserDataChat(ChatId) as Map<String, dynamic>;
    //Map<String,dynamic> F=getUserData(FriendId) as Map<String, dynamic>;

    //U['Chat']=

    // await store.doc(ChatId).set({
    //   'ChatItem':Chat,
    // });

    print('Data stored successfully!');
  } catch (e) {
    print('Error storing data: $e');
  }

}

Future<Map<String, dynamic>> getUserDataChat(String userId,String Friend) async {
  late Map<String, dynamic> userData;
  try {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('user').doc(userId).collection('chat');
    QuerySnapshot querySnapshot = await usersCollection.where('chatId', isEqualTo: Friend).get();
    // Check if the document exists
    if (querySnapshot.docs.isNotEmpty) {
      // There should be only one document with a matching user ID
      DocumentSnapshot document = querySnapshot.docs.first;
      // Access document data using document.data() as a Map
      userData = document.data() as Map<String, dynamic>;
      // Access specific fields
      // String userName = userData['name'];
      // int userAge = userData['age'];
      // Do something with the user data
      //
      // return userData;
    } else {
      print('User with ID $userId not found.');
    }
  } catch (e) {
    print('Error fetching user data: $e');
  }
  return userData;
}

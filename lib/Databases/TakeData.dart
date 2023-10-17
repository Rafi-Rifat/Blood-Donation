import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getUserData(String userId) async {
  try {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await usersCollection.where('userId', isEqualTo: userId).get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot document = querySnapshot.docs.first;
      Map<String, dynamic> userData = (await document.data()) as Map<String, dynamic>;

      if (userData != null) {
        return userData;
      } else {
        throw Exception('User data not found for ID: $userId');
      }
    } else {
      throw Exception('User with ID $userId not found.');
    }
  } catch (e) {
    print('Error fetching user data: $e');
    throw e;
  }
}
void storeDataFriend(Map<String,String> items,String userId) async {
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

Future<Map<String, dynamic>> getUserDataChat(String userId) async {
  late Map<String, dynamic> userData;
  try {
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Chat');
    QuerySnapshot querySnapshot = await usersCollection.where('userId', isEqualTo: userId).get();
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

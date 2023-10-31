import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('test/$fileName').putFile(file);
      final downloadURL = await storage.ref('test/$fileName').getDownloadURL();
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }
}

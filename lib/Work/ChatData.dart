import 'package:auth_app/Databases/Firestore.dart';
import 'package:auth_app/Databases/TakeData.dart';

  String genChatId(String userId,String friendsId){
    String chatId=userId+friendsId;
    return chatId;
  }
  bool ExistChatId(String userId,String friendsId){
    Map<String,dynamic> take=getUserData(userId) as Map<String, dynamic>;
    Map<String,String> F=take['Friends'];
    String putu=userId+friendsId;
    if(F[friendsId]==putu){
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> UploadChat(String chat,String chatId1,String chatId2,List<String> item)async {
    List<String>putki=item;
    List<String>catki=item;
    putki.insert(0, chat);
    putki.insert(0, '1');
    catki.insert(0, chat);


  }

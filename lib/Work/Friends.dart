import 'package:auth_app/Databases/Firestore.dart';
import 'package:auth_app/Databases/TakeData.dart';

class friends{
  late Map<String,String> FriendsId;
  late List<String> item;

  void LoadFriendsId(String userId){
      late Map< String, dynamic> F;
      F=getUserData(userId) as Map<String, dynamic>;

      FriendsId=F['Friends'];
  }
  void addfriendsintoList(String userId,String friendId){
    late Map<String,dynamic> f;
    f=getUserData(userId) as Map<String, dynamic>;
    item=f['items'];
    item.add(friendId);
    storeDataFriendList(item, userId);
  }

  void addFriends(String userId,String FrienId,String chatId){
    LoadFriendsId(userId);
    FriendsId[FrienId]=chatId;
    storeDataFriend(FriendsId, userId);
    //addfriendsintoList(userId, FrienId);
  }

}
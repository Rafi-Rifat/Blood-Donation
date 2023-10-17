import 'package:auth_app/Databases/TakeData.dart';
import 'package:auth_app/Work/Calulate%20distance.dart';
import 'package:auth_app/Work/Distance.dart';
import 'package:collection/collection.dart';
import 'dart:collection';

import 'package:google_maps_flutter/google_maps_flutter.dart';
class Pair<A, B> {
  final A first;
  final B second;

  Pair(this.first, this.second);
}

class makeUserTree{

  late List<String> peoplearroundyou;


  late Map<String,List<String>> ListOfFriends;
   late Map<String,bool> Known,yon;
  // var customComparator = (Pair<String, int> a, Pair<String, int> b) {
  //   return a.second.compareTo(b.second); // Compare based on the integer value (second element of the pair)
  // };

  var PQ = PriorityQueue<Pair<String, double>>(
          (a, b) => a.second.compareTo(b.second));


  int count=20;

  Future<void> MTree(String UId)async {
    if(Known[UId]==true)return;
    Known[UId]=true;
    Map<String,dynamic> userData=getUserData(UId) as Map<String, dynamic>;
    List<String>nunu=userData['connection'];
    ListOfFriends[UId]=nunu;
    for(int i=0;i<nunu.length;i++){
      MTree(nunu[i]);
    }
  }
  Future<void> findpeople(String uid,double lat1,double lon1)async {

    if(yon[uid]==true)return;
    yon[uid]=true;

    for(var l in ListOfFriends[uid]!){
       Map<String,dynamic> store=getUserData(uid) as Map<String, dynamic>;
       double dis=calculateDistance(lat1, lon1, store['lat'], store['lang']);
       dis=-1*dis;
       PQ.add(Pair(l, dis));
    }


  }

  Future<void> CreateList(uid)async {
    Map<String,dynamic> store=getUserData(uid) as Map<String, dynamic>;
    double lat1=store['lat'];
    double lon1=store['lang'];
    int count=7;
    PQ.add(Pair(uid, 0));
    for(int i=0;i<count;i++){
      String yoo=PQ.removeFirst() as String;
      peoplearroundyou.add(yoo);
      findpeople(uid, lat1, lon1);
    }
  }


  // Future<void> bfs(uid)async {
  //   PQ.add(Pair(uid, 0));
  //   while(PQ.length!=0){
  //     String n=PQ.removeFirst() as String;
  //     findpeople(uid, lat1, lon1)
  //   }
  // }

}
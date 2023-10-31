import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Databases/TakeData.dart';

class DonerData {
  final String Uid;
  final String name;
  final bool IsOnline = false;
  final DonerLatLang;

  const DonerData(this.Uid, this.name,this.DonerLatLang);
}

Future<DonerData> peopleToDoner(String uid) async {
  try {
    Map<String, dynamic> data = await getUserData(uid) as Map<String, dynamic>;
    String name = data['name'];
    LatLng lt=LatLng(data['lat'], data['lang']);
    DonerData d = DonerData(uid, name,lt);
    return d;
  } catch (error) {
    print('Error: $error');
    throw Exception('Error: $error');
  }
}

// Example of how to use the async function:

import 'package:auth_app/Databases/TakeData.dart';
import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/Work/Calulate%20distance.dart';
import 'package:auth_app/Work/Tree.dart';
import 'package:get/get.dart';

Future<void> ListOfLife(List<String> ogo) async {
  final Controller cont = Get.find();

  for (var l in ogo) {
    Map<String, double> store = getUserData(l) as Map<String, double>;
    double dis = calculateDistance(
        cont.lt.latitude, cont.lt.longitude, store['lat']!, store['lang']!);
    // cont.people.add(Pair(l, dis));
  }
  cont.people.sort((a, b) => a.second.compareTo(b.second));
}

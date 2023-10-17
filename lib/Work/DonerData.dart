import '../Databases/TakeData.dart';

class DonerData {
  final String Uid;
  final String name;
  final bool IsOnline = false;

  const DonerData(this.Uid, this.name);
}

Future<DonerData> peopleToDoner(String uid) async {
  try {
    Map<String, dynamic> data = await getUserData(uid) as Map<String, dynamic>;
    String name = data['name'];
    DonerData d = DonerData(uid, name);
    return d;
  } catch (error) {
    print('Error: $error');
    throw Exception('Error: $error');
  }
}

// Example of how to use the async function:

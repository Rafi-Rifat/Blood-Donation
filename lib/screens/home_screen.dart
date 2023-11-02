import 'package:auth_app/Databases/TakeData.dart';
import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/Work/DonerData.dart';
import 'package:auth_app/screens/post.dart';
import 'package:auth_app/screens/posts.dart';
import 'package:auth_app/screens/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_app/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'request.dart';
import 'update_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:auth_app/Databases/TakeData.dart';
import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/Work/DonerData.dart';
import 'package:auth_app/screens/posts.dart';
import 'package:auth_app/screens/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_app/screens/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'request.dart';
import 'update_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _currentUser;
  late int _selectedIndex;
  final Controller cont = Get.find();
  late User us;

  @override
  void initState() {
    _currentUser = widget.user;
    _selectedIndex = cont.homeIndex;
    super.initState();
    us = cont.Cuser1;
  }

  // Define your pages for each bottom navigation tab
  final List<Widget> _pages = [
    HomeScreen1(),
    RequestPage(), // Replace with your Blood Request page
    UpdatePage(
      requestAccepted: true,
    ),
    ChatListPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 70,
        title: Text("RedDrops"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(80)),
              gradient: LinearGradient(
                  colors: [Colors.red, Colors.pink],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 100),
            const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              radius: 45,
              // backgroundImage: NetworkImage(
              //     ),
              backgroundImage: AssetImage('images/profile_image.png'),
            ),
            SizedBox(height: 10),
            Container(
              child: WillPopScope(
                onWillPop: () async {
                  final logout = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Are you sure?'),
                        content:
                            const Text('Do you want to logout from this App'),
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Logout();
                            },
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                  return logout!;
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'NAME: ${_currentUser.displayName}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'EMAIL: ${_currentUser.email}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          cont.pu = false;

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                          Column(
                            children: [
                              Text("Hello"),
                              Text("World"),
                              Text("Goodbye")
                            ]
                                .animate(interval: 4000.ms)
                                .fade(duration: 3000.ms),
                          );
                        },
                        child: const Text('Sign out'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 255, 4, 4)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_outlined),
              title: const Text('Blood Request'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RequestPage()), // Replace RequestPage() with the appropriate widget from request.dart
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: const Text('Update'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdatePage(
                            requestAccepted: true,
                          )), // Replace RequestPage() with the appropriate widget from request.dart
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.post_add),
              title: const Text('Posts'),
              onTap: () async {
                print('on      tap');

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChatListPage()), // Replace RequestPage() with the appropriate widget from request.dart
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SettingsPage()), // Replace RequestPage() with the appropriate widget from request.dart
                );
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) async {
          if (index == 3) {
            print('on      tap');
            try {
              CollectionReference usersCollection =
                  FirebaseFirestore.instance.collection('users');
              QuerySnapshot querySnapshot = await usersCollection
                  .where('userId', isEqualTo: cont.CusID)
                  .get();
              if (querySnapshot.docs.isNotEmpty) {
                DocumentSnapshot document = querySnapshot.docs.first;
                Map<String, dynamic> userData =
                    (await document.data()) as Map<String, dynamic>;
                if (userData['NeedToAdd'] != null) {
                  cont.NeedToAdd = List<String>.from(userData['NeedToAdd']);
                  List<String> pl = [];
                  pl.add('1');
                  await usersCollection
                      .doc(cont.CusID)
                      .set({'NeedToAdd': pl}, SetOptions(merge: true));
                }
              }
            } catch (e) {
              print('Field to take NeedToAdd $e');
            }
            for (var i in cont.NeedToAdd) {
              int index = cont.ChatPerson.indexOf(i);
              String name = '';
              late LatLng lt;
              String em = ' ';
              String bl = ' ';
              String img = 'images/blood.jpg';
              if (index == -1 && i != '1') {
                try {
                  CollectionReference usersCollection =
                      FirebaseFirestore.instance.collection('users');
                  QuerySnapshot querySnapshot =
                      await usersCollection.where('userId', isEqualTo: i).get();
                  if (querySnapshot.docs.isNotEmpty) {
                    DocumentSnapshot document = querySnapshot.docs.first;
                    Map<String, dynamic> userData =
                        (await document.data()) as Map<String, dynamic>;
                    name = userData['name'];
                    em = userData['email'];
                    bl = userData['bl'];
                    lt = LatLng(userData['lat'], userData['lang']);
                    if (userData['image'] != null) {
                      img = userData['image'];
                    }
                  }
                } catch (e) {
                  print('Field to take NeedToAdd 2 $e');
                }

                DonerData d = DonerData(i, name, lt, em, bl, img);
                cont.ChatPerson.insert(0, i);
                cont.items1.insert(0, d);
                print('in home chat');
              } else if (index != -1) {
                DonerData d = cont.items1[index];
                cont.items1.removeAt(index);
                cont.items1.insert(0, d);
                print('in home chat');
              }
            }
            print(cont.ChatPerson);
            //ont.peopleTodoner1();
          }
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 174, 21, 67),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 174, 21, 67),
            icon: Icon(Icons.favorite_outlined),
            label: 'Blood Request',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 174, 21, 67),
            icon: Icon(Icons.update),
            label: 'Update',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 174, 21, 67),
            icon: Icon(Icons.chat_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 174, 21, 67),
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 2, 67, 76),
              Color.fromARGB(255, 246, 245, 243)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CarouselSlider(
                items: [
                  //  Image.asset('images/blood_donation-removebg.png'),
                  Image.asset('images/blood1-removebg-preview.png'),
                  Image.asset('images/blood2-removebg-preview.png'),
                  Image.asset('images/blood4-removebg-preview.png'),
                ],
                options: CarouselOptions(
                  height: 200.0, // Adjust the height as needed.
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
              ),
              SizedBox(height: 200.0),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to navigate to the blood donation request page.
                },
                child: const Text('Donate Blood'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to navigate to the blood donation request list page.
                },
                child: Text('Find Blood Donors'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

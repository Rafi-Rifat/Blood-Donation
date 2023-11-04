import 'package:auth_app/GET/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth_app/screens/home_screen.dart';
import 'package:auth_app/screens/signup_screen.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Databases/MakeUserList.dart';
import '../helper/firebase_auth.dart';
import '../helper/validator.dart';

// function to implement the google signin

// creating firebase instance
final FirebaseAuth auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Controller cont = Get.find();

  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            user: user,
          ),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 125),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Image.asset('images/RedDrops.png'),
                    ),
                    const SizedBox(height: 8.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.transparent,
                                  child: const Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Colors.black,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black,
                                ),
                                child: TextFormField(
                                  controller: _emailTextController,
                                  focusNode: _focusEmail,
                                  obscureText: false,
                                  validator: (value) => Validator.validateEmail(
                                    email: value,
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: "Email",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    hintStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.transparent,
                                  child: const Text(
                                    "Password",
                                    style: TextStyle(
                                      color: Colors.black,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black,
                                ),
                                child: TextFormField(
                                  controller: _passwordTextController,
                                  focusNode: _focusPassword,
                                  obscureText: true,
                                  validator: (value) =>
                                      Validator.validatePassword(
                                    password: value,
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    hintStyle: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 44.0),
                          _isProcessing
                              ? CircularProgressIndicator()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          _focusEmail.unfocus();
                                          _focusPassword.unfocus();

                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              _isProcessing = true;
                                            });

                                            User? user =
                                                await FirebaseAuthHelper
                                                    .signInUsingEmailPassword(
                                              email: _emailTextController.text,
                                              password:
                                                  _passwordTextController.text,
                                            );
                                            cont.CusID = user!.uid;
                                            cont.Cuser1 = user;
                                            try {
                                              double l = 0, m = 0;
                                              CollectionReference
                                                  usersCollection =
                                                  FirebaseFirestore.instance
                                                      .collection('users');
                                              QuerySnapshot querySnapshot =
                                                  await usersCollection
                                                      .where('userId',
                                                          isEqualTo: cont.CusID)
                                                      .get();
                                              if (querySnapshot
                                                  .docs.isNotEmpty) {
                                                DocumentSnapshot document =
                                                    querySnapshot.docs.first;
                                                Map<String, dynamic> userData =
                                                    (await document.data())
                                                        as Map<String, dynamic>;
                                                l = userData['lat'];
                                                m = userData['lang'];
                                              }
                                              print(
                                                  '                 DK                                 DK                        DK        ');
                                              cont.lt = LatLng(l, m);
                                              print(l);
                                            } catch (e) {
                                              print(
                                                  'Error fetching user data: $e');
                                              throw e;
                                            }
                                            try {
                                              //cont.people=await fetchUserIds();
                                              //print(yoo);
                                              print(
                                                  'daddjakjwakndajdandkamdkaj');
                                              //controller.people=yoo;
                                              await cont.peopleTodoner();
                                              // print('jdamadmadnkanda');
                                              // print(controller.items.length);
                                            } catch (e) {
                                              print('ERROR:$e');
                                            }

                                            setState(() {
                                              _isProcessing = false;
                                            });

                                            if (user != null) {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(user: user),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: const Text(
                                          'Sign In',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blue),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ))),
                                      ),
                                    ),
                                    SizedBox(width: 24.0),
                                    // Text("Don't have an account?"),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'SignUp',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blue),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ))),
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 40),
                          // const Center(
                          //   child: Text(
                          //     '- Or Sign In with -',
                          //     style: TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     SignUpScreen()));
                          //       },
                          //       child: Container(
                          //         width: 60,
                          //         height: 60,
                          //         padding: const EdgeInsets.all(5),
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(15),
                          //           color: Colors.white38,
                          //         ),
                          //         child: Image.asset('images/g.png'),
                          //       ),
                          //     ),
                          //     const SizedBox(width: 50),
                          //   ],
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

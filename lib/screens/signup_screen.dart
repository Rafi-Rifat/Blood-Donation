import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_app/screens/home_screen.dart';
import 'package:auth_app/helper/firebase_auth.dart';
import 'package:auth_app/helper/validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 4, 118, 124),
          title: Text('Create Account'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          // padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Image.asset('images/techn.png'),
                ),
                const SizedBox(height: 8.0),
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.white,
                              child: const Text(
                                "Name",
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
                              controller: _nameTextController,
                              focusNode: _focusName,
                              obscureText: true,
                              validator: (value) => Validator.validateName(
                                name: value,
                              ),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Name",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.text_fields,
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // TextFormField(
                      //   controller: _nameTextController,
                      //   focusNode: _focusName,
                      //   validator: (value) => Validator.validateName(
                      //     name: value,
                      //   ),
                      //   decoration: InputDecoration(
                      //     hintText: "Name",
                      //     errorBorder: UnderlineInputBorder(
                      //       borderRadius: BorderRadius.circular(6.0),
                      //       borderSide: BorderSide(
                      //         color: Colors.red,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 12.0),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.white,
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
                              obscureText: true,
                              validator: (value) => Validator.validateEmail(
                                email: value,
                              ),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Email",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // TextFormField(
                      //   controller: _emailTextController,
                      //   focusNode: _focusEmail,
                      //   validator: (value) => Validator.validateEmail(
                      //     email: value,
                      //   ),
                      //   decoration: InputDecoration(
                      //     hintText: "Email",
                      //     errorBorder: UnderlineInputBorder(
                      //       borderRadius: BorderRadius.circular(6.0),
                      //       borderSide: BorderSide(
                      //         color: Colors.red,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 12.0),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: Colors.white,
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
                              validator: (value) => Validator.validatePassword(
                                password: value,
                              ),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "Password",
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
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
                      // TextFormField(
                      //   controller: _passwordTextController,
                      //   focusNode: _focusPassword,
                      //   obscureText: true,
                      //   validator: (value) => Validator.validatePassword(
                      //     password: value,
                      //   ),
                      //   decoration: InputDecoration(
                      //     hintText: "Password",
                      //     errorBorder: UnderlineInputBorder(
                      //       borderRadius: BorderRadius.circular(6.0),
                      //       borderSide: BorderSide(
                      //         color: Colors.red,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 44.0),
                      _isProcessing
                          ? CircularProgressIndicator()
                          : Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _isProcessing = true;
                                      });

                                      if (_registerFormKey.currentState!
                                          .validate()) {
                                        User? user = await FirebaseAuthHelper
                                            .registerUsingEmailPassword(
                                          name: _nameTextController.text,
                                          email: _emailTextController.text,
                                          password:
                                              _passwordTextController.text,
                                        );

                                        setState(() {
                                          _isProcessing = false;
                                        });

                                        if (user != null) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(user: user),
                                            ),
                                            ModalRoute.withName('/'),
                                          );
                                        }
                                      } else {
                                        setState(() {
                                          _isProcessing = false;
                                        });
                                      }
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ))),
                                    // style: ButtonStyle(
                                    //   backgroundColor:
                                    //       MaterialStateProperty.all(
                                    //           Color.fromARGB(255, 4, 118, 124)),
                                    // ),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

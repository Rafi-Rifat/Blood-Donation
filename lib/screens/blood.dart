import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class blood extends StatefulWidget {
  const blood({super.key});

  @override
  State<blood> createState() => _bloodState();
}

class _bloodState extends State<blood> {
  Controller cont = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('select your blood'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TextFormField(
          //   controller: cont.Blood,
          //   //focusNode: _focusEmail,
          //   obscureText: false,
          // ),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      Radio<String>(
                        value: 'A+',
                        groupValue: cont.Blood.text,
                        onChanged: (value) {
                          cont.BRequest.text = value!;
                        },
                      ),
                      Text('A+'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<String>(
                        value: 'B+',
                        groupValue: cont.Blood.text,
                        onChanged: (value) {
                          cont.BRequest.text = value!;
                        },
                      ),
                      Text('B+'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<String>(
                        value: 'O+',
                        groupValue: cont.Blood.text,
                        onChanged: (value) {
                          cont.BRequest.text = value!;
                        },
                      ),
                      Text('O+'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<String>(
                        value: 'AB+',
                        groupValue: cont.Blood.text,
                        onChanged: (value) {
                          cont.BRequest.text = value!;
                        },
                      ),
                      Text('AB+'),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      Radio<String>(
                        value: 'A-',
                        groupValue: cont.Blood.text,
                        onChanged: (value) {
                          cont.BRequest.text = value!;
                        },
                      ),
                      Text('A-'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<String>(
                        value: 'B-',
                        groupValue: cont.Blood.text,
                        onChanged: (value) {
                          cont.BRequest.text = value!;
                        },
                      ),
                      Text('B-'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<String>(
                        value: 'O-',
                        groupValue: cont.Blood.text,
                        onChanged: (value) {
                          cont.BRequest.text = value!;
                        },
                      ),
                      Text('O-'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<String>(
                        value: 'AB-',
                        groupValue: cont.Blood.text,
                        onChanged: (value) {
                          cont.BRequest.text = value!;
                        },
                      ),
                      Text('AB-'),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // TextField(
          //   controller: cont.BRequest,
          //   decoration: const InputDecoration(
          //     labelText: 'Your selected blood-group',
          //   ),
          // ),
          TextFormField(
            controller: cont.Blood,
            //focusNode: _focusEmail,
            obscureText: false,
          ),
          TextButton(
              onPressed: () {
                Get.to(() => SignUpScreen());
              },
              child: Text('import blood'))
        ],
      ),
    );
  }
}

import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/Work/ChatData.dart';
import 'package:auth_app/Work/DonerData.dart';
import 'package:auth_app/screens/Chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatText extends StatelessWidget {
  const ChatText({
    Key? key,
    required this.don,
    required this.SP,
    required this.alignment,
  }) : super(key: key);

  final DonerData don;
  final String SP;
  final bool alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: alignment
            ? MainAxisAlignment.end
            : MainAxisAlignment.start, // Align content to the end (right) or start (left) of the row
        children: [
          Container(
            decoration: BoxDecoration(
              color: alignment ? Colors.blue : Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Text(SP),
          ),
        ],
      ),
    );
  }
}

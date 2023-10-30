import 'dart:math';

import 'package:auth_app/Doner/doner.dart';
import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/Work/DonerData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListPage extends StatefulWidget {


  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final Controller ctr = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat page'),
        ),
        body: Center(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context, index) =>
            const SizedBox(height: 10,),
            itemCount: ctr.items1.length,
            itemBuilder: (context, index)  {
              int leg=ctr.items1.length;
              print('niganiga dbajhdahdjjandjabndkkankdan $leg');
              return DonorCard(donerData: ctr.items1[index],index: index,);
            },
            physics: const BouncingScrollPhysics(),

          ),
        )
    );
  }

}



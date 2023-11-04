import 'dart:math';

import 'package:auth_app/Doner/doner.dart';
import 'package:auth_app/GET/controller.dart';
import 'package:auth_app/Work/DonerData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePage extends StatefulWidget {
  final bool requestAccepted;

  UpdatePage({required this.requestAccepted});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final Controller ctr = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Update Page'),
        // ),
        body: Center(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: ctr.items.length,
        itemBuilder: (context, index) {
          int leg = ctr.items.length;
          //print('niganiga dbajhdahdjjandjabndkkankdan $leg');
          return DonorCard(
            donerData: ctr.items[index],
            index: index,
          );
        },
        physics: const BouncingScrollPhysics(),
      ),
    ));
  }
}

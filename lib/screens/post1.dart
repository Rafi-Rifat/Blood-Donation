import 'package:auth_app/Work/PostData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final postData pos;

  const PostCard({Key? key, required this.pos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pos.name),
            Text(pos.date),
            SizedBox(height: 10),
            Text(pos.postText),
          ],
        ),
      ),
    );
  }
}

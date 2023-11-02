// import 'package:auth_app/Work/PostData.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class PostCard extends StatelessWidget {
//   final postData pos;

//   const PostCard({Key? key, required this.pos}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(pos.name),
//             Text(pos.date),
//             SizedBox(height: 10),
//             Text(pos.postText),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:auth_app/Work/PostData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final postData pos;

  const PostCard({Key? key, required this.pos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Add elevation for a shadow effect.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Add rounded corners.
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0), // Add padding to ListTile.
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pos.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            // Text(
            //   pos.date,
            //   style: TextStyle(
            //     color: Colors.grey,
            //   ),
            // ),
            SizedBox(height: 10),
            Text(
              pos.postText,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

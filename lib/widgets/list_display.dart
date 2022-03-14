import 'package:flutter/material.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ListDisplay extends StatefulWidget {
  @override
  ListDisplayState createState() => ListDisplayState();
}

// similar to camera_screen.dart file provided by module/lecture
class ListDisplayState extends State<ListDisplay> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return Column(children: [ Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var post = snapshot.data!.docs[index];

                return ListTile(
                  leading: Text(
                    DateFormat.yMMMMEEEEd().format(post['date'].toDate()),
                    style: TextStyle(fontSize: 25),
                  ),
                  trailing: Text(
                    post['items'].toString(),
                    style: TextStyle(fontSize: 35),
                  ),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => PostDetail(post: post)
                      )
                    );
                  },
                );
              }
            ),
          )],);
        } else {
          return const Center(
            child: CircularProgressIndicator()
          );
        }
      }
    );
  }
}

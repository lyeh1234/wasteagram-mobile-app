import 'package:flutter/material.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostDetail extends StatelessWidget {
  PostDetail({Key? key, required this.post}) : super(key: key);
  DocumentSnapshot post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
        centerTitle: true,
        leading:
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded), 
              onPressed: () {
                Navigator.pop(context, ListScreen());
              }
            ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height:30),
            Text(DateFormat.yMMMMEEEEd().format(post['date'].toDate()),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height:30),
            Container(
              child: Image.network(post['url'], fit: BoxFit.contain),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 13, color: Colors.blueGrey),
                  bottom: BorderSide(width: 13, color: Colors.blueGrey),
                  left: BorderSide(width: 10, color: Colors.blueGrey),
                  right: BorderSide(width: 10, color: Colors.blueGrey),
                ),
              ),
            ),
            const SizedBox(height:55),
            Text("${post['items']} items",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(height:55),
            Text('Location: (${post['latitude'].toString()}, ' + '${post['longitude'].toString()})',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        )
      ),
    );
  }
}

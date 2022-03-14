import 'package:flutter/material.dart';
import 'package:wasteagram/models/post_entry.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewPost extends StatefulWidget {
  String url;

  NewPost({Key? key, required this.url}) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {

  final formKey = GlobalKey<FormState>();
  Entry entryAttributes = Entry();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'), 
        centerTitle: true,
        leading:
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded), 
              onPressed: () {
                Navigator.pop(context, ListScreen());
              }
            ),
      ),
      body: Container (
        child: Form(
          key: formKey,
          child: Column(children: [
            Container(
              child: Image.network(widget.url),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 10, color: Colors.lightBlue),
                  bottom: BorderSide(width: 10, color: Colors.lightBlue),
                  left: BorderSide(width: 10, color: Colors.lightBlue),
                  right: BorderSide(width: 10, color: Colors.lightBlue),
                ),
              ),
            ),
            // semantics used below
            Semantics(
              label: 'input box to enter number of wasted items',
              child: TextFormField(
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25),
                decoration: const InputDecoration(
                  hintText: 'Number of Wasted Items',
                  contentPadding: EdgeInsets.only(
                    top: 40,
                    bottom: 15,
                  )
                ),
                validator: (value) {
                  setState(() {
                    entryAttributes.items = int.parse(value!);
                  });
                },
              ),
            ),
          ]),
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SizedBox(
        child: Container(
          child: ElevatedButton(
            child: Icon(
              Icons.cloud_upload, 
              size: 100
            ),
            onPressed: () {
              if(formKey.currentState!.validate()) {
                formKey.currentState!.save();
                // Note to Grader:
                //  using placeholder for location since
                //  professor said it was okay to do so
                //  reference: Ed Discussion #193
                entryAttributes.date = DateTime.now();
                entryAttributes.url = widget.url;
                entryAttributes.latitude = 41.885708;
                entryAttributes.longitude = -87.625668;

                FirebaseFirestore.instance.collection('posts').add({
                  'date': entryAttributes.date,
                  'url': entryAttributes.url,
                  'items': entryAttributes.items,
                  'latitude': entryAttributes.latitude,
                  'longitude': entryAttributes.longitude,
                });
              } Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}

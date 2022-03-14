import 'package:flutter/material.dart';
import 'package:wasteagram/screens/new_post.dart';
import 'package:wasteagram/widgets/list_display.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ListScreen extends StatefulWidget {
  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  File? image;
  final picker = ImagePicker();

  // similar to camera_screen.dart file provided by module/lecture
  Future getImage() async {
    var currentTime = DateTime.now();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    
    Reference storageReference = FirebaseStorage.instance.ref().child(currentTime.toString() + '.jpg');
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();

    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => NewPost(url: url)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wasteagram'),
        centerTitle: true
      ),
      body: ListDisplay(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // semantics used below
      floatingActionButton: Semantics(
        hint: 'choose an image from gallery',
        button: true,
        child: FloatingActionButton(
          child: const Icon(Icons.camera_alt_sharp),
          onPressed: () {getImage();},
        ),
      ),  
    );
  }
}

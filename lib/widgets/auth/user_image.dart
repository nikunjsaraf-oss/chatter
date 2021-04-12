import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  final Function(File pickedImage) imagePickedFunction;
  UserImage(this.imagePickedFunction);
  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File _pickedImage;
  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    final imageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = imageFile;
    });
    widget.imagePickedFunction(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: _pickedImage == null
              ? NetworkImage(
                  'https://cdn3.iconfinder.com/data/icons/user-actions-9/128/user_action_set_2_final-01-512.png')
              : FileImage(_pickedImage),
          radius: 40,
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          icon: Icon(Icons.camera),
          onPressed: pickImage,
          label: Text('Click an Image'),
        ),
      ],
    );
  }
}

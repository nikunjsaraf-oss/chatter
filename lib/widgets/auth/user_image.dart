import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File _pickedImage;
  void pickImage(ImageSource imageSource) async {
    final File image = await ImagePicker.pickImage(source: imageSource);
    setState(() {
      _pickedImage = image;
    });
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.camera),
              onPressed: () {
                pickImage(ImageSource.camera);
              },
              label: Text('Click an Image'),
            ),
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.image),
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
              label: Text('Add Image'),
            ),
          ],
        ),
      ],
    );
  }
}

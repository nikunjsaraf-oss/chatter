import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chatter/widgets/auth/auth_form_widget.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void _submitAuthForm(String email, String password, String userName,
      bool isLogin, BuildContext context) async {
    AuthResult authResult;

    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'userName': userName,
          'email': email,
        });
      }
    } on PlatformException catch (error) {
      String message = 'An error occured, please check your credentials.';
      if (error.message != null) {
        message = error.message;
      }

      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(
            message,
          ),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, isLoading),
    );
  }
}

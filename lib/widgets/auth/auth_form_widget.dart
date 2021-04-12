import 'dart:io';

import 'package:chatter/widgets/auth/user_image.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String userName,
    File imageFile,
    bool isLogin,
    BuildContext context,
  ) submitFunction;
  final bool isLoading;
  AuthForm(this.submitFunction, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _password = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _submit() {
    final bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); // to close the keyboard

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).errorColor,
          content: Text(
            'Please pick an image',
            textAlign: TextAlign.center,
          ),
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFunction(
        _userEmail.trim(),
        _password,
        _userName,
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImage(_pickedImage),
                TextFormField(
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  key: ValueKey('email'),
                  validator: (value) {
                    if (!validateEmail(value)) {
                      return 'Please enter a valid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email address'),
                ),
                if (!_isLogin)
                  TextFormField(
                    autocorrect: true,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: true,
                    key: ValueKey('username'),
                    onSaved: (value) {
                      _userName = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Usertname is short. It should be at least 4 characters!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  onSaved: (value) {
                    _password = value;
                  },
                  validator: (value) {
                    if (value.length < 6) {
                      return 'Password is short. Should be at least 6 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 12,
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    onPressed: _submit,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                    FocusScope.of(context).unfocus(); // to close
                  },
                  textColor: Theme.of(context).primaryColor,
                  child: Text(_isLogin
                      ? 'Create new account'
                      : 'I already have an account.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

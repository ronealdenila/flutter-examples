import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: submitAnonForm,
          icon: Icon(Icons.login),
          label: Text('Login'),
        ),
      ),
    );
  }
}

void submitAnonForm() async {
  await FirebaseAuth.instance.signInAnonymously().then(
    (result) {
      final User user = result.user;
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'Patient': true});
    },
  );
}

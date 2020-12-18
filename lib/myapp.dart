import 'package:Hello_Doctor/Dashboard.dart';
import 'package:Hello_Doctor/Landingpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return Dashboard();
    }
    return Landingpage();
  }
}

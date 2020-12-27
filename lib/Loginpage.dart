import 'package:Hello_Doctor/Dashboard.dart';
import 'package:Hello_Doctor/doctor_dashboard.dart';
import 'package:Hello_Doctor/doctor_register.dart';
import 'package:Hello_Doctor/model/userModel.dart';
import 'package:Hello_Doctor/user_register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;

class LoginPage extends StatefulWidget {
  final String userType;

  const LoginPage({@required this.userType});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  String error = "";
  UserModel userModel;

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim()))
          .user;

      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get()
          .then((ds) {
        setState(() {
          userModel = UserModel(
              userType: ds['userType'],
              bio: ds['bio'],
              contact: ds['contact'],
              department: ds['department'],
              email: ds['email'],
              fullName: ds['fullName'],
              password: ds['password']);
        });
      });
      if (userModel.userType == "Doctor") {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (BuildContext context) {
          return DoctorDashboard();
        }));
      } else {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (BuildContext context) {
          return MyDashboard();
        }));
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        error = e.message.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text("Login".toUpperCase()),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 230,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0)),
                          image: DecorationImage(
                              image: AssetImage('assets/images/healthcare.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: MyTextFormField(
                        icon: Icon(Icons.email),
                        isEmail: true,
                        isPassword: false,
                        labelText: 'Email Address',
                        hintText: 'Email',
                        validator: (String value) {
                          if (!validator.isEmail(value)) {
                            return 'Invalid Email';
                          }
                          return null;
                        },
                        controller: emailController,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: MyTextFormField(
                        icon: Icon(Icons.lock),
                        controller: passwordController,
                        isEmail: false,
                        labelText: 'Password',
                        hintText: 'Password',
                        isPassword: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Invalid Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    RaisedButton(
                      padding: EdgeInsets.only(left: 80.0, right: 80.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      color: Colors.indigoAccent,
                      elevation: 10.0,
                      highlightElevation: 20.0,
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          loginUser();
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    error == "" ? SizedBox() : Text(error),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          if (widget.userType == "User") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserRegister(
                                          userType: widget.userType,
                                        )));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorRegister(
                                          userType: widget.userType,
                                        )));
                          }
                        },
                        child: Center(
                          child: RichText(
                              text: TextSpan(
                                  text: 'Don\'t Have Account.',
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                TextSpan(
                                    text: 'Create New Account',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        fontStyle: FontStyle.italic))
                              ])),
                        ),
                      ),
                    ),
                    // SizedBox(height: 30),
                    // SignInButton(Buttons.Facebook, onPressed: () {})
                  ],
                ),
              ),
            ),
          ),
          isLoading
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(.5),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Please wait...",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

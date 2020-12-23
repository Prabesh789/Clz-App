import 'package:Hello_Doctor/Loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserRegister extends StatefulWidget {
  final String userType;

  const UserRegister({@required this.userType});
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isLoading = false;
  String error = "";
  void dispose() {
    fullNameController.dispose();

    contactNoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();

  void registerUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim()))
          .user;
      await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
        'fullName': fullNameController.text.trim(),
        'contect': contactNoController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'department': "",
        'bio': "",
        'userType': widget.userType,
      });
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) {
        return new LoginPage(
          userType: widget.userType,
        );
      }));
    } catch (e) {
      setState(() {
        error = e.message.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        title: Text("Register".toUpperCase()),
      ),
      body: Stack(
        children: [
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    child: MyTextFormField(
                      isEmail: false,
                      isPassword: false,
                      labelText: ' Your Full Name',
                      hintText: 'First Name',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter your  Fullname';
                        }
                        return null;
                      },
                      controller: fullNameController,
                    ),
                  ),
                  Container(
                    child: MyTextFormField(
                      isEmail: false,
                      isPassword: false,
                      labelText: ' Your Contact Number',
                      hintText: 'Contact Number',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter your Contact Number';
                        }
                        return null;
                      },
                      controller: contactNoController,
                    ),
                  ),
                  Container(
                    child: MyTextFormField(
                      isEmail: true,
                      isPassword: false,
                      labelText: 'Email Address',
                      hintText: 'Email',
                      validator: (String value) {
                        if (!validator.isEmail(value)) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      controller: emailController,
                    ),
                  ),
                  Container(
                    child: MyTextFormField(
                      isEmail: false,
                      labelText: 'Your Password',
                      hintText: 'Password',
                      isPassword: true,
                      validator: (String value) {
                        if (value.length < 8) {
                          return 'Password must be minimum 8 characters';
                        }
                        _formkey.currentState.save();
                        return null;
                      },
                      controller: passwordController,
                    ),
                  ),
                  Container(
                    child: MyTextFormField(
                      controller: confirmPasswordController,
                      isEmail: false,
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password',
                      isPassword: true,
                      validator: (String value) {
                        if (value.length < 8) {
                          return 'Password must be minimum 8 characters';
                        } else if (passwordController.text.trim() != null &&
                            passwordController.text.trim() !=
                                confirmPasswordController.text.trim()) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blueAccent,
                    child: Text('Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        _formkey.currentState.save();
                        registerUser();

                        // modelProvider.saveRegisterData();
                        // context.read<AuthenticationService>().signUp(
                        //       email: emailController.text,
                        //       password: passwordController.text,
                        //     );
                        // //all your data gets store in this.user and you have to call
                        // // database operation or service call over here
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => Loginpage()));
                      }
                    },
                  ),
                  error == "" ? SizedBox() : Text(error),
                ],
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

class MyTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Function validator;

  final bool isPassword;
  final bool isEmail;
  final TextEditingController controller;

  MyTextFormField(
      {@required this.hintText,
      @required this.validator,
      @required this.isPassword,
      @required this.isEmail,
      @required this.controller,
      @required this.labelText});

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool _obscureText = true;
  void _showPassword() {
    if (mounted)
      setState(() {
        _obscureText = !_obscureText;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: this.widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    size: 15.0,
                    color: Colors.black,
                  ),
                  onPressed: () => _showPassword(),
                )
              : SizedBox(),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
          hintText: widget.hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.indigo),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        obscureText: widget.isPassword ? _obscureText : false,
        validator: widget.validator,
        keyboardType:
            widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}

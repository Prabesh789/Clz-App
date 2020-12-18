import 'package:Hello_Doctor/Loginpage.dart';
import 'package:Hello_Doctor/model/registerModel.dart';
import 'package:Hello_Doctor/provider/registerProvider.dart';
import 'package:Hello_Doctor/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart' as validator;
//import 'package:flutter_firebase_auth/services/authentication_service.dart';

class Registerpage extends StatefulWidget {
  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigoAccent,
            title: Text('Register Here'),
          ),
          body: SingleChildScrollView(child: RegisterationForm()),
          backgroundColor: Colors.blue[100],
        ),
      ),
    );
  }
}

class RegisterationForm extends StatefulWidget {
  //Used to pass the existing data to this page
  final Model model;
  const RegisterationForm({this.model});
  @override
  _RegisterationFormState createState() => _RegisterationFormState();
}

class _RegisterationFormState extends State<RegisterationForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    contactNoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void initState() {
    final modelProvider = Provider.of<RegisterProvider>(context, listen: false);
    if (widget.model != null) {
      //Edit
      firstNameController.text = widget.model.firstName;
      modelProvider.loadAll(widget.model);
      lastNameController.text = widget.model.lastName;
      modelProvider.loadAll(widget.model);
      emailController.text = widget.model.email;
      modelProvider.loadAll(widget.model);
      contactNoController.text = widget.model.contactNo;
      modelProvider.loadAll(widget.model);
      passwordController.text = widget.model.password;
      modelProvider.loadAll(widget.model);
      //Create New
    } else {
      modelProvider.loadAll(null);
    }
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  Model user = Model();

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<RegisterProvider>(context, listen: true);
    final halfMediawidth = MediaQuery.of(context).size.width / 1.2;

    return Form(
      key: _formkey,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: halfMediawidth,
                      child: MyTextFormField(
                        labelText: ' Your First Name',
                        hintText: 'First Name',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          user.firstName = value;
                        },
                        onChanged: (String value) {
                          modelProvider.changeFname = value;
                        },
                        controller: firstNameController,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: halfMediawidth,
                      child: MyTextFormField(
                        labelText: 'Your Last Name',
                        hintText: 'Last Name',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          user.lastName = value;
                        },
                        onChanged: (String value) {
                          modelProvider.changeLname = value;
                        },
                        controller: lastNameController,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: halfMediawidth,
                      child: MyTextFormField(
                        labelText: ' Your Contact Number',
                        hintText: 'Contact Number',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your Contact Number';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          user.contactNo = value;
                        },
                        onChanged: (String value) {
                          modelProvider.changeCNo = value;
                        },
                        controller: contactNoController,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            width: halfMediawidth,
            child: MyTextFormField(
              labelText: 'Email Address',
              hintText: 'Email',
              isEmail: true,
              validator: (String value) {
                if (!validator.isEmail(value)) {
                  return 'Please enter valid email';
                }
                return null;
              },
              onSaved: (String value) {
                user.email = value;
              },
              onChanged: (String value) {
                modelProvider.changeemail = value;
              },
              controller: emailController,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            width: halfMediawidth,
            child: MyTextFormField(
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
              onSaved: (String value) {
                user.password = value;
              },
              onChanged: (String value) {
                modelProvider.changePassword = value;
              },
              controller: passwordController,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            width: halfMediawidth,
            child: MyTextFormField(
              labelText: 'Confirm Password',
              hintText: 'Confirm Password',
              isPassword: true,
              validator: (String value) {
                if (value.length < 8) {
                  return 'Password must be minimum 8 characters';
                } else if (user.password != null && value != user.password) {
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
                  modelProvider.saveRegisterData();
                  _formkey.currentState.save();
                  context.read<AuthenticationService>().signUp(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                  //all your data gets store in this.user and you have to call
                  // database operation or service call over here
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Loginpage()));
                }
              })
        ],
      ),
    );
  }
}

mixin modelProvider {}

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final bool isPassword;
  final bool isEmail;
  final controller;

  MyTextFormField(
      {this.hintText,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.isPassword = false,
      this.isEmail = false,
      this.controller,
      this.labelText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: null,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.indigo),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}

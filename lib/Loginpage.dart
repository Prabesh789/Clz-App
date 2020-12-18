import 'package:Hello_Doctor/Dashboard.dart';
import 'package:Hello_Doctor/Registerpage.dart';
import 'package:Hello_Doctor/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(
          'Hi, Your are in Loginpage',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: MyLoginpage(),
      backgroundColor: Colors.white,
    );
  }
}

class MyLoginpage extends StatefulWidget {
  @override
  _MyLoginpageState createState() => _MyLoginpageState();
}

class _MyLoginpageState extends State<MyLoginpage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
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
                padding: EdgeInsets.all(2.0),
                margin: EdgeInsets.only(left: 4, right: 20),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'rai@gmail.com',
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 4, right: 20),
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Enter Password',
                    labelText: 'Password',
                  ),
                  obscureText: true,
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
                  // if (context.read<AuthenticationService>().logIn(
                  //           email: emailController.text,
                  //           password: passwordController.text,
                  //         ) !=
                  //     null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                //},
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registerpage()));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

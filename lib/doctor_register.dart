import 'package:Hello_Doctor/Loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;

class DoctorRegister extends StatefulWidget {
  final String userType;

  const DoctorRegister({@required this.userType});
  @override
  _DoctorRegisterState createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  final GlobalKey<FormState> _formkeyValue = new GlobalKey<FormState>();
  var selectedType;
  List<String> _departmentType = <String>[
    'General Physician',
    'Gynecologist',
    'Cardiologist',
    'Paediatricians',
    'Dentist',
    'Pulmonologist',
    'Endocrinologists',
    "Dermatologists ",
    'Ophthalmologist ',
    'Nutritionists',
    'Medical Oncologist',
    'Reproductive endocrinologists',
    'Others'
  ];

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  bool isLoading = false;
  String error = "";
  void dispose() {
    fullNameController.dispose();
    contactController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void registerUser() async {
    if (mounted)
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
        'contact': contactController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
        'department': selectedType,
        'bio': bioController.text.trim(),
        'userType': widget.userType,
      }).then((value) {
        FirebaseAuth.instance.signOut();
      });
      if (mounted)
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
      if (mounted)
        setState(() {
          error = e.message.toString();
          isLoading = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final halfMediawidth = MediaQuery.of(context).size.width / 1.3;
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Create Your Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            Form(
              key: _formkeyValue,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: halfMediawidth,
                    child: nameTextField(fullNameController),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: halfMediawidth,
                    child: contactNoTextField(contactController),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: halfMediawidth,
                    child: emailTextField(emailController),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: halfMediawidth,
                    child: passwoerdTextField(passwordController),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) {
                          return "Please select department";
                        }
                        return null;
                      },
                      dropdownColor: Colors.white,
                      items: _departmentType
                          .map((value) => DropdownMenuItem(
                                child: Text(
                                  value,
                                  //style: TextStyle(color: Color(0xff11b719)),
                                ),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (selectedDepartmentType) {
                        if (mounted)
                          setState(() {
                            selectedType = selectedDepartmentType;
                          });
                      },
                      value: selectedType,
                      isExpanded: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.teal,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        prefixIcon: Icon(
                          Icons.medical_services,
                          color: Colors.green,
                        ),
                        labelText: 'Select Your Department',
                        labelStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      width: halfMediawidth,
                      child: descriptionTextField(bioController)),
                  RaisedButton(
                    padding: EdgeInsets.only(left: 100, right: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    color: Colors.indigo,
                    elevation: 10.0,
                    highlightElevation: 20.0,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (_formkeyValue.currentState.validate()) {
                        registerUser();
                      }
                    },
                  ),
                  error == "" ? SizedBox() : Text(error),
                ],
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
      ),
    );
  }
}

Widget nameTextField(TextEditingController fullNameController) {
  return TextFormField(
    controller: fullNameController,
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.indigoAccent,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: 'Full Name',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'Prabesh Kirat Rai'),
  );
}

Widget contactNoTextField(TextEditingController contactController) {
  return TextFormField(
    controller: contactController,
    validator: (value) {
      if (value.isEmpty) {
        return "Enter Contact Number";
      }
      return null;
    },
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.green,
        ),
        labelText: 'Mobile/Phome Number',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: '+977 982-083828'),
    maxLength: 16,
    keyboardType: TextInputType.phone,
  );
}

Widget emailTextField(TextEditingController emailController) {
  return TextFormField(
    controller: emailController,
    validator: (String value) {
      if (!validator.isEmail(value)) {
        return 'Invalid Email';
      }
      return null;
    },
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.green,
        ),
        labelText: 'Email address',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'rai@gmail.com'),
    keyboardType: TextInputType.emailAddress,
  );
}

Widget passwoerdTextField(TextEditingController passwordController) {
  return TextFormField(
    controller: passwordController,
    validator: (value) {
      if (value.length < 6) {
        return "Legnth must be min 6 character";
      }
      return null;
    },
    obscureText: true,
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.green,
        ),
        labelText: 'Password',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'Password'),
    keyboardType: TextInputType.emailAddress,
  );
}

Widget descriptionTextField(TextEditingController bioController) {
  return TextFormField(
    maxLines: 5,
    controller: bioController,
    validator: (value) {
      if (value.isEmpty) {
        return "Write Something";
      }
      return null;
    },
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
        labelText: 'Write about your-self.',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'I am Dr. .......'),
    maxLength: 250,
  );
}

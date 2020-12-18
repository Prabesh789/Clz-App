import 'package:Hello_Doctor/Dashboard.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      theme: ThemeData(primaryColor: Colors.indigoAccent),
      home: MyProfilepage(),
    );
  }
}

class MyProfilepage extends StatefulWidget {
  @override
  _MyProfilepageState createState() => _MyProfilepageState();
}

class _MyProfilepageState extends State<MyProfilepage> {
  final GlobalKey<FormState> _formkeyValue = new GlobalKey<FormState>();
  var selectedType;
  List<String> _departmentType = <String>[
    'General Physicians',
    'Gynecology',
    'Cardiology',
    'Pediatrics',
    'Dentist',
    'Pulmonology',
    'Diabetes',
    "STD's",
    'Others'
  ];
  @override
  Widget build(BuildContext context) {
    final halfMediawidth = MediaQuery.of(context).size.width / 1.3;
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Create Your Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Form(
        key: _formkeyValue,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(8.0),
                width: halfMediawidth,
                child: nameTextField()),
            Container(
                padding: EdgeInsets.all(8.0),
                width: halfMediawidth,
                child: nameTextField()),
            Container(
                padding: EdgeInsets.all(8.0),
                width: halfMediawidth,
                child: contactNoTextField()),
            Container(
                padding: EdgeInsets.all(8.0),
                width: halfMediawidth,
                child: emailTextField()),
            Row(
              children: <Widget>[
                Icon((Icons.wallpaper)),
                SizedBox(
                  width: 2.0,
                ),
                DropdownButton(
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
                    setState(() {
                      selectedType = selectedDepartmentType;
                    });
                  },
                  value: selectedType,
                  isExpanded: false,
                  hint: Text(
                    'Choose Your Department',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                  ),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.all(8.0),
                width: halfMediawidth,
                child: descriptionTextField()),
            Container(
                padding: EdgeInsets.all(8.0),
                width: halfMediawidth,
                child: submitButton(context)),
          ],
        ),
      ),
    );
  }
}

Widget nameTextField() {
  return TextFormField(
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

Widget contactNoTextField() {
  return TextFormField(
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

Widget emailTextField() {
  return TextFormField(
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

Widget descriptionTextField() {
  return TextFormField(
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
        labelText: 'Write about your-self',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'I am Dr. .......'),
    maxLength: 250,
  );
}

Widget submitButton(BuildContext context) {
  return RaisedButton(
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
            fontSize: 16,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Dashboard()));
      });
}

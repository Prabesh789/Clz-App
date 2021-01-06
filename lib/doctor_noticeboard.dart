import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DoctorNoticeBoard extends StatefulWidget {
  final String notice;

  const DoctorNoticeBoard({Key key, this.notice}) : super(key: key);
  @override
  _DoctorNoticeBoardState createState() => _DoctorNoticeBoardState();
}

class _DoctorNoticeBoardState extends State<DoctorNoticeBoard> {
  String uId;
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (user != null) {
        setState(() {
          uId = user.uid;
        });
      }
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  String _date;
  bool isLoading = false;
  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      //
    );

    if (_datePicker != null) {
      setState(() {
        _date = DateFormat('MMM dd,yyyy').format(_datePicker);
        datecontroller.text = _date;
      });
    }
  }

  void postNotice() async {
    setState(() {
      isLoading = true;
    });
    try {
      FirebaseFirestore.instance
          .collection('user')
          .doc(uId)
          .collection('notice')
          .doc()
          .set({
        //update
        'title': titlecontroller.text.trim(),
        'date': _date,
        'description': descriptioncontroller.text.trim(),
      });
      setState(() {
        isLoading = false;
        titlecontroller.clear();
        datecontroller.clear();
        descriptioncontroller.clear();
        _date = null;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Notice",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Board",
              style: TextStyle(color: Colors.blueAccent),
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Notice",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: TextFormField(
                          controller: titlecontroller,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Write Something";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Notice Title:',
                              labelText: 'Notice Title'),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: TextFormField(
                          controller: datecontroller,
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Write Something";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: (_date.toString()),
                            labelText: 'Date: yy-mm-dd',
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            suffix: Image.asset(
                              'assets/images/event.gif',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        child: TextFormField(
                          controller: descriptioncontroller,
                          maxLines: 8,
                          textInputAction: TextInputAction.done,
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
                              labelText: 'Notice Details.',
                              labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                              hintText: 'This notice .....'),
                          maxLength: 250,
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            postNotice();
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Post',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
      ),
    );
  }
}

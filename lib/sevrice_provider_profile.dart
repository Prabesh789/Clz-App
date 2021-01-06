import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewDoctorProfile extends StatefulWidget {
  @override
  _ViewDoctorProfileState createState() => _ViewDoctorProfileState();
}

class _ViewDoctorProfileState extends State<ViewDoctorProfile> {
  String uid;
  bool isEdit = false; //To edit Bio
  var focusNode = FocusNode(); //Enable focused for Bio field
  TextEditingController biocontroller = TextEditingController();
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen(
      (User user) async {
        if (user != null) {
          setState(() {
            uid = user.uid;
          });
        }
      },
    );
    super.initState();
  }

//Method to Update bio in database
  void updateBio() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update({'bio': biocontroller.text.trim()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My",
              style: TextStyle(color: Colors.blue[900]),
            ),
            SizedBox(
              width: 08,
            ),
            Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('user').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            biocontroller.text = snapshot.data['bio'];
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  CircleAvatar(
                    maxRadius: 60,
                    minRadius: 60,
                    backgroundImage:
                        CachedNetworkImageProvider(snapshot.data['photoUrl']),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full Name",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${snapshot.data['fullName']}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Divider(),
                        Text(
                          "Contact",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${snapshot.data['contact']}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Divider(),
                        Text(
                          "Department",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${snapshot.data['department']}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Divider(),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${snapshot.data['email']}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "About Doctor",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    isEdit = true;
                                    FocusScope.of(context)
                                        .requestFocus(focusNode);
                                  });
                                })
                          ],
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          focusNode: focusNode,
                          enabled: isEdit,
                          controller: biocontroller,
                          maxLines: 5,
                          textInputAction: TextInputAction.send,
                          onFieldSubmitted: (value) {
                            updateBio();
                          },
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

import 'package:Hello_Doctor/user_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'model/userModel.dart';

class MyPatients extends StatefulWidget {
  @override
  _MyPatientsState createState() => _MyPatientsState();
}

class _MyPatientsState extends State<MyPatients> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 5),
            Text(
              'Patients',
              style: TextStyle(color: Colors.blue[700]),
            )
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(uId)
            .collection('myPatients')
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshots.data.documents.length <= 0) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text('No patients avaiable yet !'),
              ),
            );
          } else {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: snapshots.data.documents.length,
              itemBuilder: (context, index) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .where('documentID',
                          isEqualTo: snapshots.data.documents[index].documentID)
                      .snapshots(),
                  builder: (context, snapshots) {
                    if (!snapshots.hasData) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshots.data.documents.length <= 0) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text('No patients avaiable yet !'),
                        ),
                      );
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: snapshots.data.documents.length,
                        itemBuilder: (context, index) {
                          final data = snapshots.data.documents[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UserDetails(
                                    userModel: UserModel(
                                        uid: data.id,
                                        bio: data['bio'],
                                        contact: data['contact'],
                                        department: data['department'],
                                        email: data['email'],
                                        fullName: data['fullName'],
                                        password: "",
                                        verificationDoc:
                                            data['verificationDoc'],
                                        photoUrl: data['photoUrl']),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    maxRadius: 35,
                                    minRadius: 35,
                                    backgroundImage: CachedNetworkImageProvider(
                                        data['photoUrl']),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${data['fullName']}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

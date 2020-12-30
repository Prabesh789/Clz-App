import 'package:Hello_Doctor/ChatScreens/chat.dart';
import 'package:Hello_Doctor/model/userModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InsideDepartment extends StatefulWidget {
  final String department;

  InsideDepartment({@required this.department});

  @override
  _InsideDepartmentState createState() => _InsideDepartmentState();
}

class _InsideDepartmentState extends State<InsideDepartment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
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
          children: <Widget>[
            Text(
              "${widget.department}",
              style: TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              width: 5,
            ),
            Flexible(
              child: Text(
                "Department",
                style: TextStyle(color: Colors.blue),
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .where('department', isEqualTo: widget.department)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshots.data.documents.length <= 0) {
            return Center(
              child: Text('No doctors avaiable for ${widget.department}'),
            );
          } else {
            return ListView.separated(
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
                        builder: (context) => DoctorDetails(
                          userModel: UserModel(
                              uid: data.id,
                              bio: data['bio'],
                              contact: data['contact'],
                              department: data['department'],
                              email: data['email'],
                              fullName: data['fullName'],
                              password: "",
                              verificationDoc: data['verificationDoc'],
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
                          backgroundImage:
                              CachedNetworkImageProvider(data['photoUrl']),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${data['fullName']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DoctorDetails extends StatelessWidget {
  final UserModel userModel;

  const DoctorDetails({Key key, @required this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(userModel.uid);
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "View",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Doctor Profile",
              style: TextStyle(color: Colors.green[900]),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            CircleAvatar(
              maxRadius: 60,
              minRadius: 60,
              backgroundImage:
                  CachedNetworkImageProvider(this.userModel.photoUrl),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full Name",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${this.userModel.fullName}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Divider(),
                  Text(
                    "Contact",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${this.userModel.contact}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Divider(),
                  Text(
                    "Department",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${this.userModel.department}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Divider(),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${this.userModel.email}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Divider(),
                  Text(
                    "About Doctor",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${this.userModel.bio}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Divider(),
                  SizedBox(height: 40),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          child: Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/chat.gif',
                                  height: 35,
                                  width: 35,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Chat',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Chat(
                                  peerId: this.userModel.uid,
                                  peerAvatar: this.userModel.photoUrl,
                                ),
                              ),
                            );
                          },
                        ),
                        InkWell(
                          child: Container(
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/noticeboard.png',
                                  height: 35,
                                  width: 35,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'View Notice',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:Hello_Doctor/ChatScreens/chat.dart';
import 'package:Hello_Doctor/model/userModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final UserModel userModel;

  const UserDetails({Key key, @required this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(userModel.uid); //print user id for check
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
              "Patient Profile",
              style: TextStyle(color: Colors.blue[700]),
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
                    "Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${this.userModel.email}',
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
                                builder: (context) => ChatScreen(
                                  peerId: this.userModel.uid,
                                  peerAvatar: this.userModel.photoUrl,
                                ),
                              ),
                            );
                          },
                        ),
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

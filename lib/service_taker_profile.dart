import 'package:Hello_Doctor/model/userModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ServiceTakerProfile extends StatefulWidget {
  final UserModel userModel;

  const ServiceTakerProfile({Key key, this.userModel}) : super(key: key);
  @override
  _ServiceTakerProfileState createState() => _ServiceTakerProfileState();
}

class _ServiceTakerProfileState extends State<ServiceTakerProfile> {
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
      body: SingleChildScrollView(
          // child: Column(
          //   children: [
          //     SizedBox(height: 10),
          //     CircleAvatar(maxRadius: 60, minRadius: 60, backgroundImage:
          //          CachedNetworkImageProvider(this.userModel.photoUrl),
          //         ),
          //     Container(
          //       padding: EdgeInsets.all(10),
          //       margin: EdgeInsets.all(20),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10), color: Colors.white),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Full Name",
          //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          //           ),
          //           SizedBox(height: 5),
          //           Text('${this.userModel.fullName}',
          //             style: TextStyle(fontSize: 15),),
          //           Divider(),
          //           Text(
          //             "Contact",
          //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          //           ),
          //           SizedBox(height: 5),
          //           Text('${this.userModel.contact}',
          //             style: TextStyle(fontSize: 15),),
          //           Divider(),
          //           Text(
          //             "Email",
          //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          //           ),
          //           SizedBox(height: 5),
          //           Text('${this.userModel.email}',
          //             style: TextStyle(fontSize: 15),),
          //           Divider(),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}

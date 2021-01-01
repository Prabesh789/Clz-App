import 'package:flutter/material.dart';

class ViewDoctorProfile extends StatefulWidget {
  @override
  _ViewDoctorProfileState createState() => _ViewDoctorProfileState();
}

class _ViewDoctorProfileState extends State<ViewDoctorProfile> {
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
        child: Column(
          children: [
            SizedBox(height: 10),
            CircleAvatar(maxRadius: 60, minRadius: 60, backgroundImage: null
                // CachedNetworkImageProvider(this.userModel.photoUrl),
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
                  Text(""
                      // '${this.userModel.fullName}',
                      // style: TextStyle(fontSize: 15),
                      ),
                  Divider(),
                  Text(
                    "Contact",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(""
                      // '${this.userModel.contact}',
                      // style: TextStyle(fontSize: 15),
                      ),
                  Divider(),
                  Text(
                    "Department",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(""
                      // '${this.userModel.department}',
                      // style: TextStyle(fontSize: 15),
                      ),
                  Divider(),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(""
                      // '${this.userModel.email}',
                      // style: TextStyle(fontSize: 15),
                      ),
                  Divider(),
                  Text(
                    "About Doctor",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(""
                      // '${this.userModel.bio}',
                      // style: TextStyle(fontSize: 15),
                      ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:Hello_Doctor/newsView/news_home_page.dart';
import 'package:Hello_Doctor/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorDashboard extends StatefulWidget {
  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: SizedBox(),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return SplashScreen();
                  }));
                });
              })
        ],
        backgroundColor: Colors.indigoAccent,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Doctor Dashboard',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            myPatientButton(context),
            SizedBox(height: 15),
            inquaryDeskButton(context),
            SizedBox(height: 15),
            newsarticleButton(context),
            SizedBox(height: 80),
            Container(
              color: Colors.white,
              height: 400,
              width: 350,
              child: Column(
                children: <Widget>[
                  Text(
                    "Thank you for being our service provider but you must have submit your document's related with your acadamic and experience to provide any service to our service taker.",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "To Upload Doc\nDouble Click in add icon",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onDoubleTap: () {},
                      child: Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  (imageUrl != null)
                      ? Image.network(imageUrl)
                      : Placeholder(
                          fallbackHeight: 150,
                          fallbackWidth: double.infinity,
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // uploadImage() async {
  //   final _picker = ImagePicker;
  //   final _storage = FirebaseStorage.instance;

  //   PickedFile image;
  //   // Check Permissions
  //   await Permission.photos.request();

  //   var permissionStatus = await Permission.photos.status;
  //   if (permissionStatus.isGranted) {
  //     //Setect images
  //     image = await _picker.getImage(source: ImageSource.gallery);

  //     var file = File(image.path);
  //     if (image != null) {
  //       //Upload to Firebase
  //       var snapshot = await _storage
  //           .ref()
  //           .child('Doctors Document/ Documents')
  //           .putFile(file)
  //           .onComplete;

  //       var downloadurl = await snapshot.ref.getDownloadURL();
  //       setState(() {
  //         imageUrl = downloadurl;
  //       });
  //     } else {
  //       print('No path Received');
  //     }
  //   } else {
  //     print('Grant Permission and try again');
  //   }
  // }
}

Widget myPatientButton(BuildContext context) {
  return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.blueAccent[100],
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        'My Patients',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {});
}

Widget inquaryDeskButton(BuildContext context) {
  return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.blueAccent[100],
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        'Inquary Desk',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {});
}

Widget newsarticleButton(BuildContext context) {
  return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.blueAccent[100],
      elevation: 10.0,
      highlightElevation: 30.0,
      child: Text(
        'News Article',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewsHomePage()));
      });
}

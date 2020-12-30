import 'package:Hello_Doctor/doctor_noticeboard.dart';
import 'package:Hello_Doctor/myPatients.dart';
import 'package:Hello_Doctor/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorDashboard extends StatefulWidget {
  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  List<String> _doctorAttributes = <String>["My Patients", "Notice Board"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: SizedBox(),
        actions: [
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return SplashScreen();
                }));
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Center(
                child: Text("Log Out"),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.indigoAccent,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            "Doctor's Dashboard",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: GridView(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          CustomGridContainer(
            title: "${_doctorAttributes[0]}",
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyPatients()));
            },
          ),
          CustomGridContainer(
            title: "${_doctorAttributes[1]}",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DoctorNoticeBoard()));
            },
          ),
        ],
      ),
    );
  }
}

class CustomGridContainer extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomGridContainer({@required this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$title",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}

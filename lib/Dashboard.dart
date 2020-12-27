import 'package:Hello_Doctor/Widget/departmentbtn.dart';
import 'package:Hello_Doctor/inquary_desk.dart';
import 'package:Hello_Doctor/inside_department.dart';
import 'package:Hello_Doctor/other_department.dart';
import 'package:Hello_Doctor/newsView/news_home_page.dart';
import 'package:Hello_Doctor/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart'; as http;

class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  List<String> _departmentType = <String>[
    'General Physician',
    'Gynecologist',
    'Cardiologist',
    'Paediatricians',
    'Dentist',
    'Pulmonologist',
    'Endocrinologists',
    "Dermatologists ",
    'Ophthalmologist ',
    'Nutritionists',
    'Medical Oncologist',
    'Reproductive endocrinologists',
    'Others'
  ];

  List<String> _departmentDetail = <String>[
    'adhahjdgh',
    'dfgh',
    'adhahjvcacsdgh',
    'adhaasdahjdgh',
    'adhahacsdajdgh',
    'adhahjdgh',
    'asdbb',
    'ewert',
    'dfgfghfgh',
    'adhahjdgh',
    'asdrth',
    'adhahjdgh',
    'f4t63',
  ];
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
            'Dashboard',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: _departmentType.length,
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${_departmentType[index]}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => InsideDepartment(
                                department: _departmentType[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "View All Doctors",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          viewDetails(
                            context: context,
                            detail: _departmentDetail[index],
                          );
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Learn More...",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void viewDetails({BuildContext context, String detail}) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: Text("$detail"),
            ),
          );
        });
  }
}

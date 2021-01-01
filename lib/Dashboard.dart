import 'package:Hello_Doctor/inside_department.dart';
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
    "General Physicians are highly trained specialists who provide a range of"
        " non-surgical health care to adult patients. They care for difficult, "
        "serious or unusual medical problems and continue to see the patient until"
        " these problems have resolved or stabilised.",
    "Gynecologists are doctors who specialize in women's health, with a focus on"
        " the female reproductive system. They deal with a wide range of issues, "
        "including obstetrics, or pregnancy and childbirth, menstruation and "
        "fertility issues, sexually transmitted infections (STIs), hormone "
        "disorders, and others.",
    "Cardiologists are doctors who diagnose, assess and treat patients with "
        "diseases and defects of the heart and blood vessels (the cardiovascular "
        "system). This page provides useful information on the nature of the work,"
        " the common procedures/interventions, sub-specialties and other roles that"
        " may interest you.",
    "Pediatricians (also known as Paediatricians) are doctors who provide "
        "medical care and advice for babies, children, and teenagers. Their role "
        "could involve anything from administering immunisations and carrying out"
        " routine health checks, to diagnosing and treating a range of injuries and "
        "illnesses.",
    "Dentists are medical healthcare professionals who work with patients to "
        "treat dental and oral disease and injuries and to prevent dental health "
        "problems. As a dentist, you will typically be examining the dental and oral"
        " hygiene of patients, and either offering advice, or carrying out dental "
        "and surgical procedures.",
    "A pulmonologist is a physician who specializes in the respiratory system."
        " From the windpipe to the lungs, if your complaint involves the lungs or "
        "any part of the respiratory system, a pulmonologist is the doc you want to"
        " solve the problem. Pulmonology is a medical field of study within internal"
        " medicine.",
    'The most common diseases treated by an endocrinologist include diabetes '
        'mellitus type 1 and type 2, Thyroid disorders, hypothyroidism, '
        'hyperthyroidism, and goiter. An endocrinologist is a specialist doctor who '
        'treats imbalances of hormones or the endocrine system of the body',
    "A dermatologist is a doctor who specializes in conditions involving the "
        "skin, hair, and nails. A dermatologist can identify and treat more than "
        "3,000 conditions. These conditions include eczema, psoriasis, and skin "
        "cancer, among many others.",
    'An ophthalmologist — Eye M.D. — is a medical or osteopathic doctor who'
        ' specializes in eye and vision care. Ophthalmologists differ from '
        'optometrists and opticians in their levels of training and in what they '
        'can diagnose and treat.',
    'A nutritionist is a person who advises others on matters of food and '
        'nutrition and their impacts on health.',
    "A doctor who has special training in diagnosing and treating cancer in "
        "adults using chemotherapy, hormonal therapy, biological therapy, and "
        "targeted therapy. A medical oncologist often is the main health care "
        "provider for someone who has cancer.",
    "Reproductive Endocrinology is a sub-specialty of Obstetrics and Gynecology."
        " This requires 4 years of medical school followed by completion of a 4 year"
        " residency in Obstetrics and Gynecology. Training includes: Medical and "
        "surgical treatment of disorders of the female reproductive tract.",
    'If any doctor are other then in the Given list, We will add them in our '
        'doctor list with new update, Thank you.',
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
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.blue[900]),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.blueGrey[50],
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Dashboard',
            style: TextStyle(color: Colors.black),
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
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Text(
              "$detail",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}

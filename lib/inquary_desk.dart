import 'package:flutter/material.dart';

class InquaryDesk extends StatefulWidget {
  @override
  _InquaryDeskState createState() => _InquaryDeskState();
}

class _InquaryDeskState extends State<InquaryDesk> {
  List<String> _listTitle = <String>[
    "What is 'Hello Doctor' is about?",
    "How do we get Health Service?",
    "How do we give Health Service?",
    "How do we know that doctor is for real?",
    "Do Service Taker and Service have same Dashboard?",
    "Do we get health related article?",
    "How do doctors can give their time?",
    "How Service Taker know doctor is avaiable or not?"
  ];
  List<String> _listDescription = <String>[
    "This is a digital platform to provide and take health services. Here, "
        "Doctor's are the service provider and public are service taker.",
    "You can Choose doctors from department that you are searching for and can "
        "consult with them through chat.",
    "Thank you Doctor, you are here after successful registeration. i.e you are"
        "listed as a doctor of your particular department. Now, all service taker can see"
        "see you in doctors list they read your bio and they decided to take consult from you",
    "We check the doctor verification document of doctor's after each registration of Doctor's",
    "Sorry, both have dofferent dashboard and attributes but there are some similar operations.",
    "Of course you can view health article including other categories news like Sprot's, Business, "
        "Technology and Science.",
    "Doctors can published notice from notice board for avaiablity and for any important information",
    "You can View the notice published by doctor, where you can find doctors avaiablity and other "
        "many imporatant information."
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Inquary",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Text(
              " Desk",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: _listTitle.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(horizontal: 20),
            title: Text(
              _listTitle[index],
              style: TextStyle(fontSize: 18),
            ),
            children: [
              Text(
                _listDescription[index],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          );
        },
      ),
    );
  }
}

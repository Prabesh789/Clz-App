import 'package:Hello_Doctor/doctor_dashboard.dart';
import 'package:Hello_Doctor/inquary_desk.dart';
import 'package:Hello_Doctor/newsView/news_home_page.dart';
import 'package:Hello_Doctor/sevrice_provider_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DoctorMainScreen extends StatefulWidget {
  @override
  _DoctorMainScreenState createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  String photoUrl;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0xff, 241, 241, 254),
      body: TabBarView(
        physics: BouncingScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          DoctorDashboard(),
          InquaryDesk(),
          NewsHomePage(),
          ViewDoctorProfile(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(0xff, 241, 241, 254),
          boxShadow: [
            new BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              blurRadius: 5.0,
            ),
          ],
        ),
        child: TabBar(
          isScrollable: false,
          physics: BouncingScrollPhysics(),
          controller: _tabController,
          labelColor: Color.fromRGBO(26, 52, 98, .87),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 1.0,
          indicatorPadding: EdgeInsets.only(bottom: 5),
          indicatorColor: Color.fromRGBO(26, 52, 98, .87),
          unselectedLabelColor: Colors.blueGrey,
          labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          tabs: <Widget>[
            Tab(
              icon: Image.asset(
                'assets/images/attributes.PNG',
                height: 30,
                width: 30,
              ),
              text: "Doctor Attributes",
            ),
            Tab(
              icon: Image.asset(
                'assets/images/inquiry.png',
                height: 30,
                width: 30,
              ),
              text: "Inquiry Desk",
            ),
            Tab(
              icon: Image.asset(
                'assets/images/newspaper.png',
                height: 20,
                width: 20,
              ),
              text: "News Articles",
            ),
            Tab(
              icon: Image.asset(
                'assets/images/myprofile.png',
                height: 20,
                width: 20,
              ),
              text: "My Profile",
            ),
          ],
        ),
      ),
    );
  }
}

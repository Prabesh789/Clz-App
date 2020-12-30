import 'package:Hello_Doctor/inquary_desk.dart';
import 'package:Hello_Doctor/newsView/news_home_page.dart';
import 'package:Hello_Doctor/service_taker_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Dashboard.dart';

class UserMainScreen extends StatefulWidget {
  @override
  _UserMainScreenState createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen>
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
          MyDashboard(),
          InquaryDesk(),
          NewsHomePage(),
          ServiceTakerProfile(),
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
                'assets/images/doctor.png',
                height: 30,
                width: 30,
              ),
              text: "Departments",
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
              text: "News Article",
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

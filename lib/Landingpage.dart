import 'package:Hello_Doctor/Loginpage.dart';
import 'package:flutter/material.dart';

class Landingpage extends StatefulWidget {
  @override
  _LandingpageState createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 260,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/health.jpg'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Get started As',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(
                                userType: "Doctor",
                              )));
                },
                child: Container(
                  width: 150.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 20.0),
                          blurRadius: 30.0,
                          color: Colors.black12)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  child: Row(children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 110.0,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 22.0),
                      child: Text(
                        "Service Provider",
                        style: Theme.of(context).textTheme.button.apply(
                              color: Colors.black,
                            ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(95.0),
                              topLeft: Radius.circular(95.0),
                              bottomRight: Radius.circular(200.0))),
                    ),
                    Icon(Icons.favorite, size: 30.0)
                  ]),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(
                                userType: "User",
                              )));
                },
                child: Container(
                  width: 150.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 20.0),
                          blurRadius: 30.0,
                          color: Colors.black12)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  child: Row(children: <Widget>[
                    Container(
                      height: 50.0,
                      width: 110.0,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 22.0),
                      child: Text(
                        "Service Taker",
                        style: Theme.of(context).textTheme.button.apply(
                              color: Colors.black,
                            ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(95.0),
                              topLeft: Radius.circular(95.0),
                              bottomRight: Radius.circular(200.0))),
                    ),
                    Icon(Icons.favorite_border, size: 30.0)
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

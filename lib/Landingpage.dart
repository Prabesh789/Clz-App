import 'package:Hello_Doctor/Loginpage.dart';
import 'package:Hello_Doctor/Profile.dart';
import 'package:flutter/material.dart';

class Landingpage extends StatefulWidget {
  @override
  _LandingpageState createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(
          'WellCone User',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Choose Who are.',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Loginpage()));
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

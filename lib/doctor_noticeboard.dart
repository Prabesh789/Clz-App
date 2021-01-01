import 'package:flutter/material.dart';

class DoctorNoticeBoard extends StatefulWidget {
  final String notice;

  const DoctorNoticeBoard({Key key, this.notice}) : super(key: key);
  @override
  _DoctorNoticeBoardState createState() => _DoctorNoticeBoardState();
}

class _DoctorNoticeBoardState extends State<DoctorNoticeBoard> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      //
    );

    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
        print(
          _date.toIso8601String(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Notice",
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Board",
              style: TextStyle(color: Colors.blueAccent),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Notice",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  Container(
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Write Something";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Notice Title:', labelText: 'Notice Title'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Write Something";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: (_date.toString()),
                    labelText: 'Date: yy-mm-dd',
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    suffix: InkWell(
                      onTap: () {
                        setState(
                          () {
                            _selectDate(context);
                          },
                        );
                      },
                      child: Image.asset(
                        'assets/images/event.gif',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: TextFormField(
                  maxLines: 8,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Write Something";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.teal,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      labelText: 'Notice Details.',
                      labelStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                      hintText: 'This notice .....'),
                  maxLength: 250,
                ),
              ),
              Divider(),
              RaisedButton(
                  elevation: 10,
                  color: Colors.blueAccent,
                  child: Text(
                    'Publish',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

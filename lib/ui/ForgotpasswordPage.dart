import 'package:flutter/material.dart';

class ForgotpasswordPage extends StatefulWidget {
  ForgotpasswordPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ForgotpasswordPage createState() => _ForgotpasswordPage();
}

class _ForgotpasswordPage extends State<ForgotpasswordPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/app-logo.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.amber[300], borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ForgotpasswordPage()));
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
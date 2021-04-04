import 'package:flutter/material.dart';
import 'package:timer_app/ui/ForgotpasswordPage.dart';
import 'package:timer_app/ui/LoginPage.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
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
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                    hintText: 'Enter first name'),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                    hintText: 'Enter last name'),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: 'Enter Phone Number'),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),

            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.amber[300], borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {

                },
                child: Text(
                  'SignUp',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: (){
                Navigator.pop(
                    context);
              },
              child: Text(
                'Existed User? Login',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
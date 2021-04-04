import 'package:flutter/material.dart';
import 'package:timer_app/blocs/login/bloc.dart';
import 'package:timer_app/utils/bloc_screen.dart';

class SignUpPage extends StatefulWidget {
  final LoginBloc loginBloc;

  SignUpPage({Key key, this.title, this.loginBloc}) : super(key: key);
  final String title;

  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _firstNameController = new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = widget.loginBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocScreen<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: _listener,
        builder: (BuildContext context, LoginState state) =>
        SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                        hintText: 'Enter first name'),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Last Name',
                        hintText: 'Enter last name'),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Phone Number',
                        hintText: 'Enter Phone Number'),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: _passwordController,
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
                    onPressed: () => attemptSignUp(context),
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
                  onPressed: ()=> Navigator.pop(context),
                  child: Text(
                    'Existed User? Login',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> attemptSignUp(BuildContext context) async {
    Scaffold.of(_formKey.currentContext).removeCurrentSnackBar();
    if (_formKey.currentState.validate()) {
      loginBloc.singUpWithEmail(_emailController.text.trim(), _passwordController.text, ('${_firstNameController.text} ${_lastNameController.text}'));
    }
  }

  void _listener(BuildContext context, LoginState state) {
    if (state is LoginErrorState) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.error)));
    } else if(state is SignUpEventSuccessState) {
      Scaffold.of(_formKey.currentContext).removeCurrentSnackBar();
      Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(content: Text("Account created successfully")));
      Navigator.of(context).pushNamed('/login');
    }
  }
}
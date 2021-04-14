import 'package:flutter/material.dart';
import 'package:timer_app/blocs/login/bloc.dart';
import 'package:timer_app/blocs/login/login_bloc.dart';
import 'package:timer_app/utils/FormValidator.dart';
import 'package:timer_app/utils/bloc_screen.dart';

class ForgotPasswordPage extends StatefulWidget {

  final LoginBloc loginBloc;
  final String title;

  ForgotPasswordPage({Key key, this.title, this.loginBloc}) : super(key: key);
  @override
  _ForgotpasswordPage createState() => _ForgotpasswordPage();
}

class _ForgotpasswordPage extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
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
        builder: (BuildContext context, LoginState state) => SingleChildScrollView(
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
                      child: Image.asset('assets/app-logo.png')),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextFormField(
                  controller: _emailController,
                  validator: FormValidator.emailAddressValidator,
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
                  onPressed: () => loginBloc.sendResetPassword(_emailController.text),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _listener(BuildContext context, LoginState state) {
    if (state is LoginErrorState) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.error)));
    } else if(state is ResetPasswordSuccessState) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Reset password success")));
    }
  }
}
import 'package:flutter/material.dart';
import 'package:timer_app/blocs/login/bloc.dart';
import 'package:timer_app/models/LoginCredentials.dart';
import 'package:timer_app/ui/ForgotpasswordPage.dart';
import 'package:timer_app/ui/SignUpPage.dart';
import 'package:timer_app/utils/FormValidator.dart';
import 'package:timer_app/utils/bloc_screen.dart';
import 'package:timer_app/utils/dependency_provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> with WidgetsBindingObserver {
  LoginBloc _loginBloc;
  LoginCredentials _loginDto = LoginCredentials();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocScreen<LoginBloc, LoginState>(
        listener: _loginStateListener,
        bloc: _loginBloc,
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
                        child: Image.asset('assets/app-logo.png')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _emailController,
                    key: Key("email_input"),
                    validator: FormValidator.emailAddressValidator,
                    onSaved: (val) => _loginDto.email = val.trim(),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter valid email id as abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
                  child: TextFormField(
                    controller: _passwordController,
                    key: Key("password_input"),
                    obscureText: true,
                    onSaved: (val) => _loginDto.password = val,
                    validator: FormValidator.formValidation,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ForgotPasswordPage(
                                  loginBloc: _loginBloc,
                                )));
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.amber[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                    onPressed: () => _onSubmit(),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  key: Key("login_submit_btn"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SignUpPage(
                                  loginBloc: _loginBloc,
                                )));
                  },
                  child: Text(
                    'New User? Create Account',
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

  @override
  void didChangeDependencies() {
    _loginBloc = LoginBloc(
      userRepo: DependencyProvider.of(context).userRepo,
      authBloc: DependencyProvider.of(context).authBloc,
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  _onSubmit() async {
    Scaffold.of(_formKey.currentContext).removeCurrentSnackBar();
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    _loginBloc.login(_loginDto);
  }

  _loginStateListener(context, LoginState state) {
    if (state is LoginErrorState) {
      Scaffold.of(_formKey.currentContext).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.error)));
    }
  }
}

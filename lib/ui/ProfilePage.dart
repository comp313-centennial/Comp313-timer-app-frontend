import 'package:flutter/material.dart';
import 'package:timer_app/common/constants.dart';
import 'package:timer_app/data/user_repo.dart';
import 'package:timer_app/models/User.dart';
import 'package:timer_app/utils/FormValidator.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key key}) : super(key: key);

  @override
  _ProfilepageState createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {

  bool editUser = false;
  final _formKey = GlobalKey<FormState>();
  UserModel user = UserModel();
  UserRepo userRepo = UserRepo();

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.headline6;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 40),
            ListTile(
              title: editableText(
                  text: globalFirebaseUser?.displayName ?? '',
                  onSaved: (val) =>
                  user = user.copyWith(displayName: val),
                  style: textStyle),
              leading: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Name:', style: textStyle),
              ),
            ),
            SizedBox(height: 30),
            if(editUser)
              ElevatedButton(onPressed: onPressed, child: Text('Submit')),
            if(!editUser)
              ElevatedButton(onPressed: () => setState(() => editUser = true), child: Text('Update Details')),
          ],
        ),
      ),
    );
  }

  Widget editableText(
      {String text, TextStyle style, Function(String) onSaved}) {
    if (this.editUser)
      return TextFormField(
        initialValue: text,
        onSaved: onSaved,
        validator: FormValidator.formValidation,
      );
    else
      return SelectableText(text, style: style);
  }

  void onPressed() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    user = user.copyWith(phoneNumber: globalFirebaseUser.phoneNumber, email: globalFirebaseUser.email);
    userRepo.updateUserData(user);
    setState(() => editUser = !editUser);
    Navigator.of(context).pushNamed('/home');
  }
}

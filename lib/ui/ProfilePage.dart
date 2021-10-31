import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = globalFirebaseUser?.displayName;
    globalFirebaseUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.headline6;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            ListTile(
              title: editableText(
                text: globalFirebaseUser?.displayName,
                  onSaved: (val) =>
                  user = user.copyWith(displayName: val),
                  controller: nameController,
                  style: textStyle),
              leading: Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Name:', style: textStyle),
              ),
            ),
            SizedBox(height: 30),
            if(editUser)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ElevatedButton(onPressed: onPressed, child: Text('Submit')),
              ),
            if(!editUser)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ElevatedButton(onPressed: () => setState(() => editUser = true), child: Text('Update Details')),
              ),
          ],
        ),
      ),
    );
  }

  Widget editableText(
      {String text, TextStyle style, Function(String) onSaved, controller}) {
    if (this.editUser)
      return TextFormField(
        onSaved: onSaved,
        controller: controller,
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
    user = user.copyWith(displayName: nameController.text, phoneNumber: globalFirebaseUser.phoneNumber, email: globalFirebaseUser.email);
    userRepo.updateUserData(user);
    globalFirebaseUser.updateDisplayName(user.displayName);
    setState(() => editUser = !editUser);
    Navigator.of(context).pushNamed('/home');
  }
}
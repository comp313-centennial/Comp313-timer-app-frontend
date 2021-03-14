import 'package:flutter/material.dart';

class HomeScreenPage extends StatefulWidget {

  final int page;

  HomeScreenPage({this.page});

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  int index = 0;
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    if(widget.page!=null) index = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'),
        actions: [
          FlatButton(
            child: Text('Logout'),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (currentIndex) => setState(() => index = currentIndex),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon:Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Create Timer'),
          BottomNavigationBarItem(
              icon:Icon(Icons.person_outline),label: 'Profile'),
          BottomNavigationBarItem(
              icon:Icon(Icons.settings),label: 'Settings'),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
      body: _children[index]
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _children = [
      Container(),
      Container(),
      Container(),
      Container(),
    ];
  }
}
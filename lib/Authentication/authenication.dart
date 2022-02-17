import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
         color: Color(0xFFFEDBD0),
          ),
          title: Text(
            "GhostWalla",style: TextStyle(
            color: Colors.black
          ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.lock,
                color: Colors.black,
              ),
                text: 'login',

              ),
              Tab(
                icon: Icon(Icons.perm_contact_calendar,
                  color: Colors.black,
                ),
                text: "Register",
              ),
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 5.0,
          ),
        ),
        body: Container(
          child: TabBarView(
            children: [
              Login(),
              Register(),
            ],
          ),
        ),
      ),
    );
  }
}

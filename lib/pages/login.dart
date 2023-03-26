import 'dart:async';
import 'dart:io';

import 'package:gap/gap.dart';
import 'package:senpass/services/authServices.dart';
import 'package:senpass/utilities/shared-ui/showSnackBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool inLoginProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo-back.png'),
                    //: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 400,
                margin: EdgeInsets.all(25),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color:Colors.black12, width: 1),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                          hintText: 'Enter Your Name',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter Password',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Se connecter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {},
                    ),
                    Gap(15),
                    Text('- Ou se connecter avec -'),
                    Gap(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        inLoginProcess ? Center(child: CircularProgressIndicator()) : ElevatedButton(child: Text(" Google "), onPressed: () => signIn(context)),
                        Gap(15),
                        inLoginProcess ? Center(child: CircularProgressIndicator()) : ElevatedButton(child: Text("Facebook"), onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn(BuildContext context) async {
    if (kIsWeb) {
      setState(() {
        inLoginProcess = true;
        AuthService().signInWithGoogle();
      });
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() async {
            inLoginProcess = true;
            AuthService().signInWithGoogle();
          });
        }
      } on SocketException catch (_) {
        showNotification(context, 'Aucune connexion internet');
      }
    }
  }
}
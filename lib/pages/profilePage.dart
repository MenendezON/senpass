import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:senpass/services/authServices.dart';

class ProfilePage extends StatelessWidget {
  final User? user;
  ProfilePage({this.user});

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            Gap(20),
            CircleAvatar(
              backgroundColor: Colors.indigo,
              radius: 105,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(_user!.photoURL!),
              ),
            ),
            Text(_user!.displayName!, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            Text(_user!.email!, style: TextStyle(fontSize: 16),),
            InkWell(
              child: const Text('Se déconnecter', style: TextStyle(color:Colors.blueAccent, fontSize: 15),),
              onTap: () => signOut(context)
            )
          ],
        ),
      ),
    );
  }

  signOut(BuildContext context) {
    Navigator.of(context).pop();
    AuthService().signOut();
  }
}



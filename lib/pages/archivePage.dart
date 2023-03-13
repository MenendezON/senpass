import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beamer/beamer.dart';
import 'package:senpass/utilities/ticketList.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({Key? key}) : super(key: key);

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  int _selectedIndex = 0;
  late final String? userID;

  void _onItemTapped(int index) {
    if(index == 1) {
      Beamer.of(context).beamToNamed('/favorite');
    }

    setState(() {
      _selectedIndex = index;
    });
  }

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
        title: Text('${_user!.uid}'),
      ),
      body: SafeArea(
        child: Scrollbar(
          isAlwaysShown: kIsWeb ? true : false,
          showTrackOnHover: kIsWeb ? true : false,
          child: CustomScrollView(slivers: [
            TicketList(pageName: 'Accueil', userID: _user!.uid)
          ]),
        ),
      ),

    );
  }
}

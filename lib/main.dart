import 'package:beamer/beamer.dart';
import 'package:senpass/models/ticketModel.dart';
import 'package:senpass/services/authServices.dart';
import 'package:senpass/services/dbServices.dart';
import 'package:senpass/utilities/shared-ui/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'beamDelegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final userID = await getCurrentUserID();
  runApp(MultiProvider(
    providers: [
      StreamProvider<User?>.value(
        initialData: null,
        value: AuthService().user,
      ),
      StreamProvider<List<Ticket>>.value(
        initialData: [],
        value: DatabaseTicketService(userID: userID).tickets,
      ),
    ],
    child: MyApp(),
  ));

  //print('Value : ${DatabaseTicketService(userID: userID).}');

}

Future<String?> getCurrentUserID() async {
  // Get the current user from the AuthService
  final currentUser = await AuthService().user.first;
  // Extract the user ID from the user object
  final userID = currentUser?.uid;
  // Return the user ID
  return userID;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {

    final _routerDelegate = routerDelegate(context);
    return BeamerProvider(
      routerDelegate: _routerDelegate,
      child: MaterialApp.router(
        title: 'Fire cars',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.amber,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        routerDelegate: _routerDelegate,
        routeInformationParser: BeamerParser(),
        builder: (context, child) {
          return StreamBuilder(
            initialData: 'loading',
            stream: AuthService().user,
            builder: (context, snapshot) {
              if (snapshot.data.toString() != 'loading') return child!;
              return const SplashScreen();
            },
          );
        },
      ),
    );
  }
}

import 'package:beamer/beamer.dart';
import 'package:senpass/pages/archivePage.dart';
import 'package:senpass/pages/homePage.dart';
import 'package:senpass/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senpass/pages/profilePage.dart';

routerDelegate(BuildContext context) {
  final _user = Provider.of<User?>(context);
  return BeamerDelegate(
    initialPath: '/home',
    notFoundRedirectNamed: '/home',
    locationBuilder: SimpleLocationBuilder(
      routes: {
        '/home': (context, state) {
          return BeamPage(
            key: ValueKey('home'),
            title: 'Accueil/Fire Cars',
            type: BeamPageType.scaleTransition,
            child: HomePage(user: _user),
          );
        },
        '/login': (context, state) {
          return BeamPage(
            key: ValueKey('login'),
            title: 'Connectez-vous/Fire Cars',
            type: BeamPageType.scaleTransition,
            child: Login(),
          );
        },
        '/profile': (context, state) {
          return BeamPage(
            key: ValueKey('profile'),
            title: '${_user!.displayName}/Fire Cars',
            type: BeamPageType.scaleTransition,
            child: ProfilePage(),
          );
        },
        '/archive': (context, state) {
          return BeamPage(
            key: ValueKey('archive'),
            title: ' ',
            type: BeamPageType.scaleTransition,
            child: ArchivePage(),
          );
        },
        /*'/favorite': (context, state) {
          return BeamPage(
            key: ValueKey('favorite'),
            title: '${_user!.displayName}/Fire Cars',
            type: BeamPageType.scaleTransition,
            child: Favorite(),
          );
        },
        '/detail/:carId': (context, state) {
          final carId = state.pathParameters['carId']!;
          return BeamPage(
            key: ValueKey('car-$carId'),
            title: 'Detail de la voiture $carId',
            type: BeamPageType.scaleTransition,
            popToNamed: '/home',
            child: CarDetail(),
          );
        }*/
      },
    ),
    guards: [
      BeamGuard(
        pathBlueprints: ['/home', '/profile', '/detail', '/detail/*'],
        check: (context, location) => _user != null,
        beamToNamed: '/login',
      ),
      BeamGuard(
        pathBlueprints: ['/'],
        check: (context, location) => _user != null,
        beamToNamed: '/home',
      ),
      BeamGuard(
        pathBlueprints: ['/login', '/'],
        check: (context, location) => _user == null,
        beamToNamed: '/home',
      ),
    ],
  );
}
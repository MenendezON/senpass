import 'package:beamer/beamer.dart';
import 'package:tutofirebase/views/detail/carDetail.dart';
import 'package:tutofirebase/views/home/home.dart';
import 'package:tutofirebase/views/login/login.dart';
import 'package:tutofirebase/views/profile/profile.dart';
import 'package:tutofirebase/views/favorite/favorite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            child: Home(),
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
            child: Profile(),
          );
        },
        '/favorite': (context, state) {
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
        }
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
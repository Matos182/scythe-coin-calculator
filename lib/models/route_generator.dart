// SPDX-License-Identifier: MIT

import '../pages/home.dart';
import '../models/players.dart';
import '../pages/player_add.dart';
import '../pages/result.dart';
import 'package:flutter/material.dart';

/// [RouteGenerator] class generates routes for navigation in the Scythe Coin Calculator app.

class RouteGenerator {
  /// [generateRoute] function generates routes based on the provided [RouteSettings].
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments as Map<String, dynamic>?;

    // Check if arguments is not null before accessing its keys
    final results = arguments?['results'] as List<Players>?;
    final playerCounter = arguments?['playerCounter'];

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) {
          results?.clear();
          playerCounter?.clear();
          return const HomePage();
        });
      case '/playerAdd':
        return MaterialPageRoute(
            builder: (_) => PlayerAddPage(
                  results: results!,
                  playerCounter: int.tryParse(playerCounter.toString()) ?? 0,
                ));
      case '/results':
        return MaterialPageRoute(
            builder: (_) => ResultPage(
                  results: results!,
                ));
      default:
        return _errorRoute();
    }
  }

  /// [_errorRoute] function generates a route for handling errors.
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(appBar: AppBar(title: const Text('ERROR')));
    });
  }
}

// SPDX-License-Identifier: MIT

/// @title: Scythe Coin Calculator
/// @description: A Flutter application for calculating scores in the board game Scythe.
/// @author: Designed by Fabio Matos
/// @version: 0.1.1

import './models/route_generator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Scythe Coin Calculator',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

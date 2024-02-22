// SPDX-License-Identifier: MIT

import '../models/players.dart';
import 'package:flutter/material.dart';

/// [ResultPage] displays the final results of the Scythe Coin Calculator.

class ResultPage extends StatelessWidget {
  final List<Players> results;

  /// Constructor to initialize [ResultPage] with a list of results.
  const ResultPage({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort the results list based on the result property in descending order
    results.sort((a, b) => b.result.compareTo(a.result));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 117, 141, 90),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 75, 13),
        title: const Text(
          "Scythe Coin Calculator",
          style: TextStyle(color: Color.fromARGB(255, 33, 116, 23)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.recycling_rounded,
              color: Color.fromARGB(255, 72, 150, 36),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Final Score - Winner:       ${results.first.name}',
              style: const TextStyle(
                color: Color.fromARGB(255, 32, 75, 13),
                fontSize: 24,
              ),
            ),
            const SizedBox(
                height: 20), // Padding some space from the winner and the table
            // Build the dynamic table based on sorted results list
            if (results.isNotEmpty) ...[
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Table(
                    border: TableBorder.all(
                      color: const Color(0xff014d07),
                      style: BorderStyle.solid,
                      width: 3,
                    ),
                    children: [
                      // Table header
                      _buildTableRow(
                        header: true,
                        children: const [
                          'Player Name',
                          'Popularity',
                          'Stars',
                          'Lands',
                          'Resources',
                          'Coins',
                          'Building Coins',
                          'TOTAL COINS',
                        ],
                      ),
                      // Table rows for each Result
                      for (var result in results)
                        _buildTableRow(children: [
                          result.name,
                          result.popularity.toString(),
                          result.stars.toString(),
                          result.lands.toString(),
                          result.resources.toString(),
                          result.coins.toString(),
                          result.buildings.toString(),
                          result.result.toString(),
                        ]),
                    ],
                  ))
            ] else
              const Text('No results found'),
          ],
        ),
      ),
    );
  }

  // Function to build a TableRow with optional header styling
  TableRow _buildTableRow({
    required List<String> children,
    bool header = false,
  }) {
    final textStyle = TextStyle(
      color: const Color.fromARGB(255, 32, 75, 13),
      fontSize: header ? 12.5 : 11,
      fontWeight: header ? FontWeight.bold : FontWeight.normal,
    );

    return TableRow(
      children: children.map((text) {
        return TableCell(
          child: Container(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

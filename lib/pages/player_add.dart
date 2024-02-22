// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import '../models/players.dart';

/// [PlayerAddPage] is a StatefulWidget that allows users to input data for each player.
/// It collects information such as player name, popularity, stars, lands, resources,
/// building coins, and coins. Users can add up to 7 players.

class PlayerAddPage extends StatefulWidget {
  final List<Players> results;
  final int playerCounter;
  const PlayerAddPage(
      {super.key, required this.results, required this.playerCounter});

  @override
  State<PlayerAddPage> createState() => _PlayerAddPageState(playerCounter); // I prefered to use logic in 'createState'
}

/// [_PlayerAddPageState] is the state class for the [PlayerAddPage].

class _PlayerAddPageState extends State<PlayerAddPage> {
  final List<TextEditingController> controllers =
      List.generate(7, (index) => TextEditingController());
  late int playerCounter;
  bool isButtonActive = true;
  Players player = Players('', 0, 0, 0, 0, 0, 0, 0);

  _PlayerAddPageState(this.playerCounter);

  /// [convert] function extracts data from text controllers, calculates the player's score,
  /// and adds the player's data to the results list.

  void convert() {
    player.name = controllers[0].text;
    player.popularity = int.tryParse(controllers[1].text) ?? 0;
    player.stars = int.tryParse(controllers[2].text) ?? 0;
    player.lands = int.tryParse(controllers[3].text) ?? 0;
    player.resources =
        ((int.tryParse(controllers[4].text) ?? 0) / 2).truncate();
    player.buildings = int.tryParse(controllers[5].text) ?? 0;
    player.coins = int.tryParse(controllers[6].text) ?? 0;

    if (player.popularity < 7) {
      player.result = player.stars * 3 +
          player.lands * 2 +
          player.resources +
          player.buildings +
          player.coins;
    } else if (player.popularity >= 7 && player.popularity < 13) {
      player.result = player.stars * 4 +
          player.lands * 3 +
          player.resources * 2 +
          player.buildings +
          player.coins;
    } else {
      player.result = player.stars * 5 +
          player.lands * 4 +
          player.resources * 3 +
          player.buildings +
          player.coins;
    }
    widget.results.add(Players(
        player.name,
        player.popularity,
        player.stars,
        player.lands,
        player.resources,
        player.buildings,
        player.coins,
        player.result));
    setState(() {});
  }

  /// [dispose] function disposes of text controllers.

  @override
  void dispose() {
    super.dispose();
    controllers[0].dispose();
    controllers[1].dispose();
    controllers[2].dispose();
    controllers[3].dispose();
    controllers[4].dispose();
    controllers[5].dispose();
    controllers[6].dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (playerCounter >= 7) {
      isButtonActive = false;
    }

    // Border style for text fields
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 72, 150, 36),
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(10),
    );

    // Function to define input decoration for text fields
    InputDecoration inputDecoration(String hintText, IconData prefixIcon) {
      return InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 33, 116, 23)),
        prefixIcon:
            Icon(prefixIcon, color: const Color.fromARGB(255, 72, 150, 36)),
        filled: true,
        fillColor: const Color.fromARGB(255, 35, 70, 19),
        focusedBorder: border,
        enabledBorder: border,
      );
    }

    // Function to build text fields
    Widget buildTextField(TextEditingController controller, String hintText,
        IconData prefixIcon, TextInputType typeOfData) {
      return Container(
        padding: const EdgeInsets.all(7.0),
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: inputDecoration(hintText, prefixIcon),
          keyboardType: typeOfData,
        ),
      );
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 117, 141, 90),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 32, 75, 13),
            title: const Text("Scythe Coin Calculator",
                style: TextStyle(color: Color.fromARGB(255, 33, 116, 23))),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: const Icon(Icons.recycling_rounded,
                      color: Color.fromARGB(255, 72, 150, 36)),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  }),
            ]),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Player ${widget.playerCounter.toString()} Score",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 32, 75, 13),
            ),
          ),
          // Text fields for player data input
          buildTextField(
              controllers[0],
              "Player ${widget.playerCounter.toString()}",
              Icons.face_6,
              TextInputType.name),
          buildTextField(controllers[1], "Popularity", Icons.favorite,
              TextInputType.number),
          buildTextField(
              controllers[2], "Stars", Icons.star, TextInputType.number),
          buildTextField(
              controllers[3], "Lands", Icons.hexagon, TextInputType.number),
          buildTextField(controllers[4], "Resources",
              Icons.my_library_add_rounded, TextInputType.number),
          buildTextField(controllers[5], "Building Coins", Icons.home_filled,
              TextInputType.number),
          buildTextField(
              controllers[6], "Coins", Icons.circle, TextInputType.number),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: ElevatedButton(
                  onPressed: isButtonActive
                      ? () {
                          convert();
                          playerCounter++;
                          Navigator.of(context).pushNamed('/playerAdd', // Arguments passed to the new page
                              arguments: {
                                'results': widget.results,
                                'playerCounter': playerCounter
                              });
                        }
                      : null,
                  style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(7),
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color.fromARGB(
                              255, 122, 120, 119); // Disabled color
                        }
                        return const Color.fromARGB(
                            255, 35, 70, 19); // Regular color
                      }),
                      foregroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 72, 150, 36)),
                      fixedSize: const MaterialStatePropertyAll(Size(150, 50))),
                  child: const Text("Add Player")),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: ElevatedButton(
                  onPressed: () {
                    convert();
                    Navigator.of(context).pushNamed('/results', // Arguments passed to the new page
                        arguments: {'results': widget.results});
                  },
                  style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(7),
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 35, 70, 19)),
                      foregroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 72, 150, 36)),
                      fixedSize: MaterialStatePropertyAll(Size(150, 50))),
                  child: const Text("Show Results")),
            )
          ])
        ])));
  }
}

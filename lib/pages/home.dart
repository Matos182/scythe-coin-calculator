// SPDX-License-Identifier: MIT

/// [Players] class represents a player in the Scythe Coin Calculator app.

import 'package:flutter/material.dart';
import '../models/players.dart';

/// [HomePage] is a StatefulWidget representing the main page of the Scythe Coin Calculator app.
/// Users input data for the first player here and can navigate to add more players.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// [_HomePageState] is the state class for the [HomePage].

class _HomePageState extends State<HomePage> {
  final List<TextEditingController> controllers =
      List.generate(7, (index) => TextEditingController());

  int playerCounter = 1;
  Players player = Players('', 0, 0, 0, 0, 0, 0, 0);
  List<Players> results = [];

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
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 72, 150, 36),
        width: 2.0,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.circular(10),
    );

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
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Player 1 Total Coins ${player.result.toString()}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 32, 75, 13),
            ),
          ),
          // Text fields for player data input
          buildTextField(
              controllers[0], "Player 1", Icons.face_6, TextInputType.name),
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
                  onPressed: convert,
                  style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(7),
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 35, 70, 19)),
                      foregroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 72, 150, 36)),
                      fixedSize: MaterialStatePropertyAll(Size(150, 50))),
                  child: const Text("Convert")),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: ElevatedButton(
                  onPressed: () {
                    convert();
                    results.add(Players(
                        player.name,
                        player.popularity,
                        player.stars,
                        player.lands,
                        player.resources,
                        player.buildings,
                        player.coins,
                        player.result));
                    playerCounter++;
                    Navigator.of(context).pushNamed('/playerAdd', arguments: {
                      'results': results,
                      'playerCounter': playerCounter,
                    });
                  },
                  style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(7),
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 35, 70, 19)),
                      foregroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 72, 150, 36)),
                      fixedSize: MaterialStatePropertyAll(Size(150, 50))),
                  child: const Text("Add Player")),
            )
          ])
        ])));
  }
}

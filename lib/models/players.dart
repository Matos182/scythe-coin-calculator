// SPDX-License-Identifier: MIT

/// [Players] class represents a player in the Scythe Coin Calculator app.

class Players {
  String name = 'Player 1';
  int popularity = 0;
  int stars = 0;
  int lands = 0;
  int resources = 0;
  int coins = 0;
  int buildings = 0;
  int result = 0;

  /// Constructor for initializing a player with provided attributes.
  Players(this.name, this.popularity, this.stars, this.lands, this.resources,
      this.buildings, this.coins, this.result);
}

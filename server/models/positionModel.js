const db = require("../config/db/index");

class Position {
  static async getPositionId(positionName) {
    return db
      .one("SELECT id FROM positions p WHERE p.name = $1", [positionName])
      .then((result) => result.id);
  }
}

module.exports = Position;

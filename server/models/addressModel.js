const db = require("../config/db/index");

class Address {
  static async getAddressId(addressData) {
    const existingAddress = await db.oneOrNone(
      "SELECT id FROM addresses WHERE city = $1 AND street = $2 AND house_number = $3",
      [addressData.city, addressData.street, addressData.house_number]
    );
    if (existingAddress) {
      return existingAddress.id;
    }
    return db
      .one(
        "INSERT INTO addresses (city, street, house_number) VALUES ($1, $2, $3) RETURNING id",
        [addressData.city, addressData.street, addressData.house_number]
      )
      .then((result) => result.id);
  }
}

module.exports = Address;

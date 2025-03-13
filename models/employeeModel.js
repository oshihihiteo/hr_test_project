const db = require("../config/db/index");

class Employee {
  static async getAll() {
    return db.any(
      "SELECT fio(e.last_name, e.first_name, e.middle_name), d.name AS department, p.name AS position " +
        "FROM employees e JOIN positions p ON p.id = e.position_id " +
        "JOIN departments d ON d.id = e.department_id"
    );
  }
}

module.exports = Employee;

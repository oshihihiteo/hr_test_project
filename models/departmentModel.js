const db = require("../config/db/index");

class Department {
  static async getDepartmentId(departmentName) {
    return db
      .one("SELECT id FROM departments d WHERE d.name = $1", [departmentName])
      .then((result) => result.id);
  }
}

module.exports = Department;

const db = require("../config/db/index");

class Employee {
  static async getAll() {
    return db.any(
      "SELECT fio(e.last_name, e.first_name, e.middle_name), d.name AS department, p.name AS position " +
        "FROM employees e JOIN positions p ON p.id = e.position_id " +
        "JOIN departments d ON d.id = e.department_id"
    );
  }

  static async create(employeeData, addressId, departmentId, positionId) {
    return db.one(
      "INSERT INTO employees (last_name, first_name, middle_name, passport_number, salary, " +
        "hire_date, phone_number, email, telegram, address_id, department_id, position_id, is_employed) " +
        "VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, true) RETURNING id",
      [
        employeeData.last_name,
        employeeData.first_name,
        employeeData.middle_name,
        employeeData.passport_number,
        employeeData.salary,
        employeeData.hire_date,
        employeeData.phone_number,
        employeeData.email,
        employeeData.telegram,
        addressId,
        departmentId,
        positionId,
      ]
    );
  }
}

module.exports = Employee;

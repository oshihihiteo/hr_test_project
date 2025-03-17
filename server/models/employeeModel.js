const db = require("../config/db/index");

class Employee {
  static async getAll() {
    return db.any(
      "SELECT e.id, e.last_name, e.first_name, e.middle_name, e.passport_number, e.salary, " +
        "e.hire_date, e.phone_number, e.email, e.telegram, e.is_employed, e.birthday, a.city, a.street, a.house_number, a.apartment, " +
        "d.name AS department, p.name AS position FROM employees e " +
        "JOIN positions p ON p.id = e.position_id " +
        "JOIN departments d ON d.id = e.department_id " +
        "JOIN addresses a ON e.address_id = a.id"
    );
  }

  static async getEmployee(id) {
    return db.oneOrNone(
      "SELECT e.id, e.last_name, e.first_name, e.middle_name, e.passport_number, e.salary, " +
        "e.hire_date, e.phone_number, e.email, e.telegram, e.birthday, a.city, a.street, a.house_number, a.apartment, " +
        "d.name AS department, p.name AS position, e.is_employed FROM employees e " +
        "JOIN positions p ON p.id = e.position_id " +
        "JOIN departments d ON d.id = e.department_id " +
        "JOIN addresses a ON e.address_id = a.id WHERE e.id = $1",
      [id]
    );
  }

  static async create(employeeData, addressId, departmentId, positionId) {
    return db.one(
      "INSERT INTO employees (last_name, first_name, middle_name, passport_number, salary, " +
        "hire_date, phone_number, email, telegram, birthday, address_id, department_id, position_id, is_employed) " +
        "VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, true) RETURNING id",
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
        employeeData.birthday,
        addressId,
        departmentId,
        positionId,
      ]
    );
  }

  static async delete(id) {
    return db.none("UPDATE employees SET is_employed = false WHERE id = $1", [
      id,
    ]);
  }

  static async edit(id, employeeData, addressId, departmentId, positionId) {
    return db.none(
      "UPDATE employees SET last_name = $1, first_name = $2, " +
        "middle_name = $3, passport_number = $4, salary = $5, hire_date = $6, " +
        "phone_number = $7, email = $8, telegram = $9, birthday = $10, address_id = $11, " +
        "department_id = $12, position_id = $13 WHERE id = $14",
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
        employeeData.birthday,
        addressId,
        departmentId,
        positionId,
        id,
      ]
    );
  }
}

module.exports = Employee;

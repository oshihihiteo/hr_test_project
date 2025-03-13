const Employee = require("../models/employeeModel");

exports.getEmployees = async (req, res) => {
  try {
    const employees = await Employee.getAll();
    res.render("employees", { employees });
  } catch (error) {
    console.error("Ошибка при получении сотрудников:", error);
    res.status(500).send("Ошибка сервера");
  }
};

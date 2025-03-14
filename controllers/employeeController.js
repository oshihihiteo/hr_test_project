const Employee = require("../models/employeeModel");
const Address = require("../models/addressModel");
const Department = require("../models/departmentModel");
const Position = require("../models/positionModel");

exports.getEmployees = async (req, res) => {
  try {
    const employees = await Employee.getAll();
    res.render("employees", { employees });
  } catch (error) {
    console.error("Ошибка при получении сотрудников:", error);
    res.status(500).send("Ошибка сервера");
  }
};

exports.createEmployeeForm = async (req, res) => {
  res.render("create-employee-form");
};

exports.createEmployee = async (req, res) => {
  const { employeeData, addressData, departmentName, positionName } = req.body;

  try {
    const addressId = await Address.getAddressId(addressData);
    const departmentId = await Department.getDepartmentId(departmentName);
    const positionId = await Position.getPositionId(positionName);

    const employee = await Employee.create(
      employeeData,
      addressId,
      departmentId,
      positionId
    );

    res.redirect("/employees");
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Ошибка сервера", error });
  }
};

exports.deleteEmployee = async (req, res) => {
  const id = parseInt(req.params.id);

  try {
    const employee = await Employee.delete(id);
    res.redirect("/employees");
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Ошибка сервера", error });
  }
};

exports.editEmployeeForm = async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const employee = await Employee.getEmployee(id);
    res.render("edit-employee-form", { employee });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Ошибка сервера", error });
  }
};

exports.editEmployee = async (req, res) => {
  const id = parseInt(req.params.id);
  console.log("id: " + id);
  const { employeeData, addressData, departmentName, positionName } = req.body;

  try {
    const addressId = await Address.getAddressId(addressData);
    const departmentId = await Department.getDepartmentId(departmentName);
    const positionId = await Position.getPositionId(positionName);

    const employee = await Employee.edit(
      id,
      employeeData,
      addressId,
      departmentId,
      positionId
    );
    res.redirect("/employees");
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Ошибка сервера", error });
  }
};

const Employee = require("../models/employeeModel");
const Address = require("../models/addressModel");
const Department = require("../models/departmentModel");
const Position = require("../models/positionModel");
const { mergeProps } = require("vue");

exports.getEmployees = async (req, res) => {
  try {
    const employees = await Employee.getAll();
    res.status(200).json({ employees });
  } catch (error) {
    console.error("Ошибка при получении сотрудников:", error);
    res.status(500).send("Ошибка сервера");
  }
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

    res.status(200).json({ message: "Сотрудник добавлен" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Ошибка сервера", error });
  }
};

exports.deleteEmployee = async (req, res) => {
  const id = parseInt(req.params.id);

  try {
    const employee = await Employee.delete(id);
    res.status(200).json({ message: "Сотрудник уволен" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Ошибка сервера", error });
  }
};

exports.getEmployeeById = async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const employee = await Employee.getEmployee(id);
    res.status(200).json({ employee });
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
    res.status(200).json({ message: "Данные сотрудника изменены" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Ошибка сервера", error });
  }
};

exports.getDepartments = async (req, res) => {
  try {
    const departments = await Department.get();
    res.status(200).json({ departments });
  } catch (error) {
    console.error("Ошибка при получении :", error);
    res.status(500).send("Ошибка сервера");
  }
};

exports.getPositions = async (req, res) => {
  try {
    const positions = await Position.get();
    res.status(200).json({ positions });
  } catch (error) {
    console.error("Ошибка при получении :", error);
    res.status(500).send("Ошибка сервера");
  }
};

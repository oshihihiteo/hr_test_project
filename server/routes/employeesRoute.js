const express = require("express");
const router = express.Router();
const employeeController = require("../controllers/employeeController");

router.get("/employees", employeeController.getEmployees);
router.get("/create", employeeController.createEmployeeForm);
router.post("/create", employeeController.createEmployee);
router.post("/delete/:id", employeeController.deleteEmployee);
router.get("/edit/:id", employeeController.editEmployeeForm);
router.post("/edit/:id", employeeController.editEmployee);

module.exports = router;

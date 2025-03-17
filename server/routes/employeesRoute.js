const express = require("express");
const router = express.Router();
const employeeController = require("../controllers/employeeController");

router.get("/employees", employeeController.getEmployees);
router.get("/employees/:id", employeeController.getEmployeeById);
router.post("/create", employeeController.createEmployee);
router.delete("/delete/:id", employeeController.deleteEmployee);
router.put("/edit/:id", employeeController.editEmployee);
router.get("/departments", employeeController.getDepartments);
router.get("/positions", employeeController.getPositions);

module.exports = router;

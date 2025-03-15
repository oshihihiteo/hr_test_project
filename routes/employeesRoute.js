const express = require("express");
const router = express.Router();
const employeeController = require("../controllers/employeeController");

router.get("/employees", employeeController.getEmployees);
router.get("/create", async (req, res) => {
  res.render("create-employee-form", {});
});
router.post("/create", employeeController.createEmployee);
router.post("/delete/:id", employeeController.deleteEmployee);

module.exports = router;

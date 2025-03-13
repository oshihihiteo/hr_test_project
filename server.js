const express = require("express");
const cors = require("cors");
const employeesRoutes = require("./routes/employeesRoute");

const app = express();
app.use(express.json());
app.use(cors());
app.use("/", employeesRoutes);

app.set("view engine", "ejs");
app.use(express.static("public"));

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Сервер запущен на порту ${PORT}`));

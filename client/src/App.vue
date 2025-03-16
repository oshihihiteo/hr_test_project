<script>
import axios from "axios";
import AddEmployeeForm from "@/components/AddEmployeeForm.vue"; // Импортируем новый компонент

export default {
  components: {
    AddEmployeeForm, // Регистрируем компонент
  },
  data() {
    return {
      employees: [],
      showForm: false, // Флаг для отображения формы
    };
  },
  methods: {
    async getEmployees() {
      try {
        const response = await axios.get("http://localhost:5000/employees");
        this.employees = response.data.employees;
      } catch (error) {
        console.error("Ошибка при загрузке данных:", error);
      }
    },

    async addEmployee(employee) {
      try {
        const response = await axios.post("http://localhost:5000/create", employee);
        this.employees.push(response.data); // Добавляем нового сотрудника в массив
        this.showForm = false; // Закрываем форму
      } catch (error) {
        console.error("Ошибка при добавлении сотрудника:", error);
      }
    },
  },
  mounted() {
    this.getEmployees();
  },
};
</script>

<template>
  <div>
    <h2>Список сотрудников</h2>
    <button @click="showForm = true">Добавить сотрудника</button>

    <!-- Модальное окно для добавления сотрудника -->
    <div v-if="showForm" class="modal-overlay">
      <AddEmployeeForm 
        :showForm="showForm" 
        @submit="addEmployee" 
        @cancel="showForm = false" />
    </div>

    <!-- Таблица сотрудников -->
    <table border="1" v-if="employees.length > 0" :class="{ 'blurred': showForm }">
      <thead>
        <tr>
          <th>ФИО</th>
          <th>Номер паспорта</th>
          <th>Зарплата</th>
          <th>Дата приема</th>
          <th>Телефон</th>
          <th>Email</th>
          <th>Телеграм</th>
          <th>Адрес</th>
          <th>Отдел</th>
          <th>Должность</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="employee in employees" :key="employee.id">
          <td>{{ employee.fio }}</td>
          <td>{{ employee.passport_number }}</td>
          <td>{{ employee.salary }}</td>
          <td>{{ employee.hire_date }}</td>
          <td>{{ employee.phone_number }}</td>
          <td>{{ employee.email }}</td>
          <td>{{ employee.telegram }}</td>
          <td>{{ employee.city + " " + employee.street + " " + employee.house_number }}</td>
          <td>{{ employee.department }}</td>
          <td>{{ employee.position }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<style scoped>
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}
th, td {
  padding: 8px;
  border: 1px solid #ddd;
  text-align: left;
}
th {
  background-color: #f4f4f4;
}

/* Модальное окно */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5); /* Полупрозрачный фон */
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

table.blurred {
  filter: blur(5px); /* Размытие таблицы */
}

/* Для компонента AddEmployeeForm */
form {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}
form div {
  margin-bottom: 10px;
}
button {
  margin-top: 10px;
}
</style>

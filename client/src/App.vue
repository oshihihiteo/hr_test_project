<script>
import axios from "axios";
import AddEmployeeForm from "@/components/AddEmployeeForm.vue";
import EmployeeCard from "@/components/EmployeeCard.vue";

export default {
  components: {
    AddEmployeeForm,
    EmployeeCard,
  },
  data() {
    return {
      employees: [],
      showForm: false,
      selectedEmployeeId: null,
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
    formatDate(date) {
      return date ? new Date(date).toISOString().split("T")[0] : "";
    },
    async addEmployee(employee) {
      try {
        const response = await axios.post(
          "http://localhost:5000/create",
          employee
        );
        this.showForm = false;
        this.getEmployees();
        alert("Сотрудник добавлен!");
      } catch (error) {
        console.error("Ошибка при добавлении сотрудника:", error);
      }
    },

    showEmployeeCard(employee) {
      this.selectedEmployeeId = employee.id;
    },

    closeEmployeeCard() {
      this.selectedEmployeeId = null;
    },

    openForm() {
      this.showForm = true;
    },

    closeForm() {
      this.showForm = false;
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

    <button @click="openForm">Добавить сотрудника</button>

    <div v-if="showForm" class="modal-overlay">
      <AddEmployeeForm @submit="addEmployee" @cancel="closeForm" />
    </div>

    <table
      border="1"
      v-if="employees.length > 0"
      :class="{ blurred: showForm || selectedEmployeeId }"
    >
      <thead>
        <tr>
          <th>ФИО</th>
          <th>Отдел</th>
          <th>Должность</th>
          <th>Зарплата</th>
          <th>Дата приема</th>
          <th>Номер паспорта</th>
          <th>Адрес</th>
          <th>Контакты</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="employee in employees"
          :key="employee.id"
          @click="showEmployeeCard(employee)"
          :style="{ color: employee.is_employed ? '' : '#ffaaaa' }"
        >
          <td>
            {{
              `${employee.last_name} ${employee.first_name} ${employee.middle_name}`
            }}
          </td>
          <td>{{ employee.department }}</td>
          <td>{{ employee.position }}</td>
          <td>{{ employee.salary }}</td>
          <td>{{ formatDate(employee.hire_date) }}</td>
          <td>{{ employee.passport_number }}</td>
          <td>
            {{
              `г.${employee.city}, ул.${employee.street}, д.${employee.house_number}`
            }}
          </td>
          <td>
            {{ employee.phone_number }}<br />
            {{ employee.email }}<br />
            {{ employee.telegram }}
          </td>
        </tr>
      </tbody>
    </table>

    <div v-if="selectedEmployeeId" class="modal-overlay">
      <EmployeeCard
        :employeeId="selectedEmployeeId"
        @close="closeEmployeeCard"
        @update="getEmployees"
      />
    </div>
  </div>
</template>

<style scoped></style>

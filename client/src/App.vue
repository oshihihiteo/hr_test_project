<template>
  <div>
    <h2>Список сотрудников</h2>
    <div class="header-menu">
      <div>
        <input
          type="text"
          v-model="searchQuery"
          placeholder="Введите ФИО сотрудника"
          @input="filterEmployees"
          class="search"
        />
      </div>

      <div class="dropdown">
        <button class="dropbtn btn">Фильтры</button>
        <div class="dropdown-content">
          <div>
            <label>Отдел:</label>
            <select v-model="selectedDepartment" @change="filterEmployees">
              <option value="">Все отделы</option>
              <option
                v-for="department in departments"
                :key="department"
                :value="department"
              >
                {{ department }}
              </option>
            </select>
          </div>
          <div>
            <label>Должность:</label>
            <select v-model="selectedPosition" @change="filterEmployees">
              <option value="">Все должности</option>
              <option
                v-for="position in positions"
                :key="position"
                :value="position"
              >
                {{ position }}
              </option>
            </select>
          </div>
        </div>
      </div>

      <button class="btn" @click="openForm">Добавить сотрудника</button>

      <div v-if="showForm" class="modal-overlay">
        <AddEmployeeForm @submit="addEmployee" @cancel="closeForm" />
      </div>
    </div>

    <table
      border="1"
      v-if="filteredEmployees.length > 0"
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
          <th>Дата рождения</th>
          <th>Адрес</th>
          <th>Контакты</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="employee in filteredEmployees"
          :key="employee.id"
          @click="showEmployeeCard(employee)"
          :style="{ color: employee.is_employed ? '' : '#ffaaaa' }"
        >
          <td>
            {{ employee.last_name }} {{ employee.first_name }}
            {{ employee.middle_name }}
          </td>
          <td>{{ employee.department }}</td>
          <td>{{ employee.position }}</td>
          <td>{{ employee.salary }}</td>
          <td>{{ formatDate(employee.hire_date) }}</td>
          <td>{{ employee.passport_number }}</td>
          <td>{{ formatDate(employee.birthday) }}</td>
          <td>
            {{ employee.city }}, ул.{{ employee.street }}, д.{{
              employee.house_number
            }}
            {{ employee.apartment ? `кв. ${employee.apartment}` : "" }}
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
      filteredEmployees: [],
      showForm: false,
      selectedEmployeeId: null,
      searchQuery: "",
      selectedDepartment: "",
      selectedPosition: "",
      departments: [],
      positions: [],
    };
  },
  methods: {
    async getEmployees() {
      try {
        const response = await axios.get("http://localhost:5000/employees");
        this.employees = response.data.employees;
        this.filteredEmployees = this.employees;
        this.departments = [
          ...new Set(this.employees.map((emp) => emp.department)),
        ];
        this.positions = [
          ...new Set(this.employees.map((emp) => emp.position)),
        ];
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

    filterEmployees() {
      this.filteredEmployees = this.employees.filter((employee) => {
        const matchesName =
          employee.last_name
            .toLowerCase()
            .includes(this.searchQuery.toLowerCase()) ||
          employee.first_name
            .toLowerCase()
            .includes(this.searchQuery.toLowerCase()) ||
          employee.middle_name
            .toLowerCase()
            .includes(this.searchQuery.toLowerCase());
        const matchesDepartment =
          this.selectedDepartment === "" ||
          employee.department === this.selectedDepartment;
        const matchesPosition =
          this.selectedPosition === "" ||
          employee.position === this.selectedPosition;

        return matchesName && matchesDepartment && matchesPosition;
      });
    },
  },
  mounted() {
    this.getEmployees();
  },
};
</script>

<style scoped>
.search {
  height: 30px;
  width: 300px;
  font-family: Verdana, sans-serif;
  font-size: 16px;
}
.header-menu {
  display: flex;
  align-items: center;
  gap: 10px;
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
  z-index: 1;
  padding: 10px;
}

.dropdown:hover .dropdown-content {
  display: block;
}

.filters-menu div {
  margin-bottom: 10px;
}

.filters-menu select {
  width: 200px;
  padding: 5px;
}
</style>

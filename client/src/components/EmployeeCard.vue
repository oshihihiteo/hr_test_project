<template>
  <div class="modal-overlay" @click.self="closeModal">
    <div class="card" v-if="!isEditing">
      <div class="form-header">
        <h3>
          {{
            `${employee.last_name} ${employee.first_name} ${employee.middle_name}`
          }}
        </h3>
        <button class="close-btn" @click="closeModal">✖</button>
      </div>

      <div class="card-section">
        <div class="card-content">
          <p>Отдел {{ employee.department }}, {{ employee.position }}</p>
          <p>Принят на должность {{ formatDate(employee.hire_date) }}</p>
          <p>
            <strong>Статус:</strong>
            {{ employee.is_employed ? "Работает" : "Уволен" }}
          </p>
          <p><strong>Зарплата:</strong> {{ employee.salary }}</p>
          <p><strong>Номер паспорта:</strong> {{ employee.passport_number }}</p>
          <p>
            <strong>Адрес:</strong> {{ employee.city }} {{ employee.street }}
            {{ employee.house_number }}
          </p>
        </div>
      </div>

      <div class="card-section">
        <p class="card-block">Контактная информация</p>
        <div class="card-content">
          <p><strong>Телефон:</strong> {{ employee.phone_number }}</p>
          <p><strong>Email:</strong> {{ employee.email }}</p>
          <p><strong>Телеграм:</strong> {{ employee.telegram }}</p>
        </div>
      </div>

      <div class="form-header">
        <button class="btn" @click="toggleEdit" v-if="employee.is_employed">
          Редактировать
        </button>
        <button class="btn" @click="deleteEmployee" v-if="employee.is_employed">
          Уволить
        </button>
      </div>
    </div>

    <EmployeeEditForm
      v-if="isEditing"
      :employee="employee"
      @cancel="toggleEdit"
      @save="handleSave"
    />
  </div>
</template>

<script>
import axios from "axios";
import dayjs from "dayjs";
import EmployeeEditForm from "@/components/EmployeeEditForm.vue";

export default {
  components: {
    EmployeeEditForm,
  },
  props: {
    employeeId: Number,
  },
  data() {
    return {
      isEditing: false,
      employee: {
        last_name: "",
        first_name: "",
        middle_name: "",
        passport_number: "",
        salary: "",
        hire_date: "",
        phone_number: "",
        email: "",
        telegram: "",
        city: "",
        street: "",
        house_number: "",
        departmentName: "",
        positionName: "",
      },
    };
  },
  methods: {
    async getEmployee() {
      try {
        const employeeId = this.employeeId;
        console.log("Вызор метода в ид" + employeeId);
        const response = await axios.get(
          `http://localhost:5000/employees/${this.employeeId}`
        );
        this.employee = response.data.employee;
        console.log(response.data);
      } catch (error) {
        console.error("Ошибка при получении сотрудника:", error);
      }
    },

    formatDate(date) {
      return date ? new Date(date).toISOString().split("T")[0] : "";
    },
    toggleEdit() {
      this.isEditing = !this.isEditing;
    },
    closeModal() {
      this.isEditing = false;
      this.$emit("close");
    },
    async handleSave(employeePayload) {
      try {
        const response = await axios.put(
          `http://localhost:5000/edit/${this.employee.id}`,
          JSON.stringify(employeePayload),
          {
            headers: { "Content-Type": "application/json" },
          }
        );
        console.log(response.data);
        await this.getEmployee();
        this.$emit("update");
        alert("Данные сотрудника обновлены!");
      } catch (error) {
        console.error("Ошибка при добавлении сотрудника:", error);
      }
    },

    async deleteEmployee() {
      const isConfirmed = confirm(
        "Вы уверены что хотите уволить данного сотрудника?"
      );

      if (isConfirmed) {
        try {
          const response = await axios.delete(
            `http://localhost:5000/delete/${this.employee.id}`
          );
          console.log(response.data);
          this.$emit("update");
          await this.getEmployee();
        } catch (error) {
          console.error("Ошибка при удалении сотрудника:", error);
        }
      } else {
        console.log("Удаление отменено");
      }
    },
  },
  mounted() {
    this.getEmployee(this.employeeId);
  },
};
</script>
<style scoped></style>

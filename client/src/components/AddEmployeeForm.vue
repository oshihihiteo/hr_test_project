<template>
  <div class="card" v-if="isFormVisible">
    <div class="form-header">
      <p><strong>Добавление сотрудника</strong></p>
      <button class="close-btn" @click="closeForm">✖</button>
    </div>

    <form @submit.prevent="submitForm">
      <div>
        <label for="lastName">Фамилия:</label>
        <input
          type="text"
          v-model="employeeData.last_name"
          id="lastName"
          required
        />
      </div>
      <div>
        <label for="firstName">Имя:</label>
        <input
          type="text"
          v-model="employeeData.first_name"
          id="firstName"
          required
        />
      </div>
      <div>
        <label for="middleName">Отчество:</label>
        <input type="text" v-model="employeeData.middle_name" id="middleName" />
      </div>
      <div>
        <label for="passportNumber">Номер паспорта:</label>
        <input
          type="text"
          v-model="employeeData.passport_number"
          id="passportNumber"
          ref="passportInput"
          placeholder="1234 567890"
          required
        />
      </div>
      <div>
        <label for="salary">Зарплата:</label>
        <input type="text" v-model="employeeData.salary" id="salary" required />
      </div>
      <div>
        <label for="hireDate">Дата приема:</label>
        <input
          type="date"
          v-model="employeeData.hire_date"
          id="hireDate"
          required
        />
      </div>
      <div>
        <label for="phoneNumber">Телефон:</label>
        <input
          type="text"
          v-model="employeeData.phone_number"
          id="phoneNumber"
          ref="phoneInput"
          placeholder="+7(___)___-__-__"
          required
        />
      </div>
      <div>
        <label for="email">Email:</label>
        <input
          type="email"
          v-model="employeeData.email"
          id="email"
          ref="emailInput"
          placeholder="example@mail.com"
          required
        />
      </div>
      <div>
        <label for="telegram">Телеграм:</label>
        <input
          type="text"
          v-model="employeeData.telegram"
          id="telegram"
          ref="telegramInput"
          placeholder="@username"
        />
      </div>
      <div>
        <label for="city">Город:</label>
        <input type="text" v-model="addressData.city" id="city" required />
      </div>
      <div>
        <label for="street">Улица:</label>
        <input type="text" v-model="addressData.street" id="street" required />
      </div>
      <div>
        <label for="houseNumber">Номер дома:</label>
        <input
          type="text"
          v-model="addressData.house_number"
          id="houseNumber"
          required
        />
      </div>

      <div>
        <label for="department">Отдел:</label>
        <select v-model="departmentName" id="department" required>
          <option
            v-for="department in departments"
            :key="department.name"
            :value="department.name"
          >
            {{ department.name }}
          </option>
        </select>
      </div>

      <div>
        <label for="position">Должность:</label>
        <select v-model="positionName" id="position" required>
          <option
            v-for="position in positions"
            :key="position.name"
            :value="position.name"
          >
            {{ position.name }}
          </option>
        </select>
      </div>
      <br />
      <button class="btn" type="submit">Добавить сотрудника</button>
    </form>
  </div>
</template>

<script>
import axios from "axios";
import { onMounted, ref } from "vue";
import Inputmask from "inputmask";

export default {
  data() {
    return {
      isFormVisible: true,
      employeeData: {
        last_name: "",
        first_name: "",
        middle_name: "",
        passport_number: "",
        salary: "",
        hire_date: "",
        phone_number: "",
        email: "",
        telegram: "",
      },
      addressData: {
        city: "",
        street: "",
        house_number: "",
      },
      departmentName: "",
      positionName: "",
      departments: [],
      positions: [],
    };
  },
  setup() {
    const phoneInput = ref(null);
    const passportInput = ref(null);
    const telegramInput = ref(null);
    const emailInput = ref(null);

    onMounted(() => {
      const mask = "+7(999)999-99-99";
      Inputmask(mask).mask(phoneInput.value);
      Inputmask("9999 999999").mask(passportInput.value);
      Inputmask("email").mask(emailInput.value);
      Inputmask({
        mask: "@***************",
        definitions: {
          "*": { validator: "[A-Za-z0-9_]" },
        },
        placeholder: "",
        clearIncomplete: true,
      }).mask(telegramInput.value);
    });

    return { phoneInput, passportInput, telegramInput, emailInput };
  },
  mounted() {
    this.loadDepartments();
    this.loadPositions();
  },
  methods: {
    async loadDepartments() {
      try {
        const response = await axios.get("http://localhost:5000/departments");
        this.departments = response.data.departments;
      } catch (error) {
        console.error("Ошибка при загрузке отделов:", error);
      }
    },
    async loadPositions() {
      try {
        const response = await axios.get("http://localhost:5000/positions");
        this.positions = response.data.positions;
      } catch (error) {
        console.error("Ошибка при загрузке должностей:", error);
      }
    },
    async submitForm() {
      const employeePayload = {
        employeeData: this.employeeData,
        addressData: this.addressData,
        departmentName: this.departmentName,
        positionName: this.positionName,
      };
      this.$emit("submit", employeePayload);
      this.closeForm;
    },
    closeForm() {
      this.$emit("cancel");
    },
  },
};
</script>

<style scoped></style>

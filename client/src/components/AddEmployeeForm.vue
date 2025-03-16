<template>
  <form @submit.prevent="submitForm">
    <div>
      <label for="lastName">Фамилия:</label>
      <input type="text" v-model="employeeData.last_name" id="lastName" required />
    </div>
    <div>
      <label for="firstName">Имя:</label>
      <input type="text" v-model="employeeData.first_name" id="firstName" required />
    </div>
    <div>
      <label for="middleName">Отчество:</label>
      <input type="text" v-model="employeeData.middle_name" id="middleName" />
    </div>
    <div>
      <label for="passportNumber">Номер паспорта:</label>
      <input type="text" v-model="employeeData.passport_number" id="passportNumber" required />
    </div>
    <div>
      <label for="salary">Зарплата:</label>
      <input type="number" v-model="employeeData.salary" id="salary" required />
    </div>
    <div>
      <label for="hireDate">Дата приема:</label>
      <input type="date" v-model="employeeData.hire_date" id="hireDate" required />
    </div>
    <div>
      <label for="phoneNumber">Телефон:</label>
      <input type="text" v-model="employeeData.phone_number" id="phoneNumber" required />
    </div>
    <div>
      <label for="email">Email:</label>
      <input type="email" v-model="employeeData.email" id="email" required />
    </div>
    <div>
      <label for="telegram">Телеграм:</label>
      <input type="text" v-model="employeeData.telegram" id="telegram" />
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
      <input type="text" v-model="addressData.house_number" id="houseNumber" required />
    </div>
    <div>
      <label for="department">Отдел:</label>
      <input type="text" v-model="departmentName" id="department" required />
    </div>
    <div>
      <label for="position">Должность:</label>
      <input type="text" v-model="positionName" id="position" required />
    </div>
    <button type="submit">Добавить сотрудника</button>
  </form>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      employeeData: {
        last_name: '',
        first_name: '',
        middle_name: '',
        passport_number: '',
        salary: '',
        hire_date: '',
        phone_number: '',
        email: '',
        telegram: ''
      },
      addressData: {
        city: '',
        street: '',
        house_number: ''
      },
      departmentName: '',
      positionName: ''
    };
  },
  methods: {
    async submitForm() {
      // Формируем полный объект, соответствующий JSON структуре
      const employeePayload = {
        employeeData: {
          last_name: this.employeeData.last_name,
          first_name: this.employeeData.first_name,
          middle_name: this.employeeData.middle_name,
          passport_number: this.employeeData.passport_number,
          salary: this.employeeData.salary,
          hire_date: this.employeeData.hire_date,
          phone_number: this.employeeData.phone_number,
          email: this.employeeData.email,
          telegram: this.employeeData.telegram
        },
        addressData: {
          city: this.addressData.city,
          street: this.addressData.street,
          house_number: this.addressData.house_number
        },
        departmentName: this.departmentName,
        positionName: this.positionName
      };

      console.log("Отправляемые данные:", employeePayload);

      // Отправляем данные на сервер
      try {
        const response = await axios.post("http://localhost:5000/create", JSON.stringify(employeePayload), {
  headers: {
    'Content-Type': 'application/json'
  }
});
        console.log(response.data);
      } catch (error) {
        console.error("Ошибка при добавлении сотрудника:", error);
      }
    }
  }
};
</script>

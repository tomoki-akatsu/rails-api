<template>
  <v-row justify="center" align="center">
    <v-col cols="12" md="6" sm="8">
      <v-card elevation="10">
        <v-card-text>
          <v-form ref="form" lazy-validation>
            <v-text-field
              v-model="name"
              :rules="nameRules"
              label="Name"
              required
              prepend-icon="mdi-account"
            ></v-text-field>

            <v-text-field
              v-model="email"
              :rules="emailRules"
              label="E-mail"
              required
              prepend-icon="mdi-email"
            ></v-text-field>

            <v-text-field
              v-model="password"
              label="Password"
              required
              prepend-icon="mdi-lock"
              type="password"
            ></v-text-field>

            <v-text-field
              v-model="passwordConfirmation"
              :rules="passwordConfirmationRules"
              label="PasswordConfirmation"
              required
              prepend-icon="mdi-lock"
              type="password"
            ></v-text-field>
          </v-form>
        </v-card-text>

        <v-card-actions>
          <router-link to="/login" class="text-decoration-none"
            >ログインページへ</router-link
          >
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="signup">新規登録</v-btn>
        </v-card-actions>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import axios from "axios";

export default {
  data: () => ({
    name: "",
    nameRules: [
      (v) => !!v || "Name is required",
      (v) => (v && v.length <= 10) || "Name must be less than 10 characters",
    ],
    email: "",
    emailRules: [
      (v) => !!v || "E-mail is required",
      (v) => /.+@.+\..+/.test(v) || "E-mail must be valid",
    ],
    password: "",
    passwordConfirmation: "",
  }),
  computed: {
    passwordConfirmationRules() {
      return [
        this.password === this.passwordConfirmation || "Password must match",
      ];
    },
  },
  methods: {
    async signup() {
      if (this.$refs.form.validate()) {
        try {
          await axios.post("api/users", {
            user: {
              name: this.name,
              email: this.email,
              password: this.password,
              password_confirmation: this.passwordConfirmation,
            },
          });
          this.$router.push("login");
        } catch (err) {
          alert(err.response.data.error.messages);
        }
      }
    },
  },
};
</script>

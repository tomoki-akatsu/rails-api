<template>
  <v-container class="fill-height" fluid>
    <v-row justify="center" align="center">
      <v-col cols="12" md="6" sm="8">
        <v-card elevation="10">
          <v-card-text>
            <v-form ref="form" lazy-validation>
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
            </v-form>
          </v-card-text>

          <v-card-actions>
            <router-link to="/signup" class="text-decoration-none"
              >ユーザー登録ページへ</router-link
            >
            <v-spacer></v-spacer>
            <v-btn color="primary" @click="login">ログイン</v-btn>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data: () => ({
    email: "",
    emailRules: [
      (v) => !!v || "E-mail is required",
      (v) => /.+@.+\..+/.test(v) || "E-mail must be valid",
    ],
    password: "",
  }),
  methods: {
    async login() {
      if (this.$refs.form.validate()) {
        try {
          const sessionParams = {
            session: {
              email: this.email,
              password: this.password,
            },
          };
          await this.$store.dispatch("auth/login", sessionParams);
          this.$router.push("/");
        } catch (err) {
          alert(err.response.data.error);
        }
      }
    },
  },
};
</script>

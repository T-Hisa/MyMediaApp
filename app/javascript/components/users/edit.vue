<template>
  <div>
    <div class="d-flex align-items-center top-margin-sm">
      <h1>ユーザー情報編集</h1>
    </div>
    <div class="container bg-light">
      <form action="">
        <div class="form-group user-edit-form">
          <label for="user_name">ユーザー名</label>
          <input v-model="name" name="user_name" type="text" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary user-edit-btn" @click="onClickNameBtn">
          変更
        </button>
        <button class="btn btn-outline-dark back-btn">戻る</button>
      </form>
      <form action="">
        <div class="user-edit-form">
          <div class="form-group">
            <label for="current_password">現在のパスワード</label>
            <input v-model="currentPassword" type="password" name="current_password" class="form-control">
          </div>
          <div class="form-group ">
            <label for="new_password">新しいパスワード</label>
            <input v-model="password" type="password" name="new_password" class="form-control">
          </div>
          <div class="form-group">
            <label for="password_confirmation">パスワード(確認)</label>
            <input v-model="passwordConfirmation" type="password" name="password_confirmation" class="form-control">
          </div>
        </div>
        <button type="submit" class="btn btn-danger user-edit-btn" @click="onClickPasswordBtn">変更</button>
        <button class="btn btn-outline-dark back-btn">戻る</button>
      </form>
    </div>
  </div>
</template>

<script>
// const axios = require('axios').default;
import axios from 'axios';

export default {
  name: "UserEdit",
  props: {
    userId: Number,
    locale: String
  },
  data: function () {
    return {
      name: String,
      currentPassword: "",
      password: "",
      passwordConfirmation: "",
      loc: String,
      uid: String
    }
  },
  computed: {
    computedUid: {
      get () {
        return this.uid;
      },
      set (value) {
        this.uid = value;
      }
    },
    computedLoc: {
      get () {
        return this.loc;
      },
      set (value) {
        this.loc = value;
      }
    }
  },
  mounted () {
    console.log(window);
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    };
    // 仕様？かわからないけど props のデータが メソッド内で呼び出したら undefined に変わってしまうので、computed プロパティを用いて保存しておく。
    this.computedUid = this.userId;
    this.computedLoc = this.locale;

    axios.get(`/${this.locale}/api/users/${this.userId}/edit`)
      .then(response => {
        let data = response.data;
        this.name = data.name;
      });
  },
  methods: {
    onClickNameBtn (e) {
      e.preventDefault();
      let sendData = {
        user: {
          name: this.name
        }
      }
      axios.patch(`/${this.loc}/api/users/${this.uid}`, sendData)
        .then(response => {
          let url = response.data.url
          window.location.href = url
        })
    },
    onClickPasswordBtn (e) {
      e.preventDefault();
    }
  }
}
</script>

<style scoped>
</style>

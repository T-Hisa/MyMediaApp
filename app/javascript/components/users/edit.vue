<template>
  <div>
    <div class="d-flex align-items-center top-margin-sm">
      <h1>ユーザー情報編集</h1>
    </div>
    <div class="container bg-light">
      <form action="">
        <div class="form-group user-edit-form">
          <label for="user_name">ユーザー名</label>
          <input name="user_name" type="text" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary user-edit-btn" @click="onClickSubmitBtn">
          変更
        </button>
        <button class="btn btn-outline-dark back-btn">戻る</button>
      </form>
      <form action="">
        <div class="user-edit-form">
          <div class="form-group">
            <label for="current_password">現在のパスワード</label>
            <input type="password" name="current_password" class="form-control">
          </div>
          <div class="form-group ">
            <label for="new_password">新しいパスワード</label>
            <input type="password" name="new_password" class="form-control">
          </div>
          <div class="form-group">
            <label for="password_confirmation">パスワード(確認)</label>
            <input type="password" name="password_confirmation" class="form-control">
          </div>
        </div>
        <button type="submit" class="btn btn-danger user-edit-btn">変更</button>
        <button class="btn btn-outline-dark back-btn">戻る</button>
      </form>
    </div>
  </div>
</template>

<script>
const axios = require('axios').default;

export default {
  name: "UserEdit",
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  methods: {
    onClickSubmitBtn () {

    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

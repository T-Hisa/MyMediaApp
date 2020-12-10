const { $ } = require("@rails/ujs");
let files = [];
let uploadingImageElement = $('#uploading-image')[0];
uploadingImageElement.oninput = (e) => {
  // アップロードされたファイルを取得し、表示する
  let file = e.target.files[0];
  files.push(files);
  let blobUrl = window.URL.createObjectURL(file);
  let imgEl = $('#uploaded-image')[0];
  imgEl.src = blobUrl;
  let imageWrapper = $("#image-preview-wrapper")[0]
  imageWrapper.style.display = "block";
  
  // 編集時、既に記事に画像が添付されている場合はその要素を削除する
  let savedImageWrapper = $('#saved-image-wrapper')[0];
  if (savedImageWrapper) {
    savedImageWrapper.style.display = "none";
  }
}

// 表示用に作成した画像専用のURLを解放する。必要かどうか分からない。
let submitEl = $('#submit-btn')[0];
submitEl.addEventListener('click', () => {
  if (files) {
    files.forEach((file) => {
      window.URL.revokeObjectURL(file);
    }) 
  }
})
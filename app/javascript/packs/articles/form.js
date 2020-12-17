const { $ } = require("@rails/ujs");

// 画像アップロード周り
let files = [];
let uploadingImageEl = $('#uploading-image')[0];
uploadingImageEl.oninput = (e) => {
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

// 表示用に作成した一時的な画像専用のURLを解放する。必要かどうか分からないから念のため。
let submitEl = $('#submit-btn')[0];
submitEl.addEventListener('click', () => {
  if (files) {
    files.forEach((file) => {
      window.URL.revokeObjectURL(file);
    }) 
  }
})

// 下書き保存用
let titleEl = $('#article_title')[0];
titleEl.onchange = (e) => {
  let titleDraftEl = $('#article_title')[1];
  titleDraftEl.value = e.target.value;
}
let contentEl = $('#article_content')[0];
contentEl.onchange = (e) => {
  let contentDraftEl = $('#article_content')[1];
  contentDraftEl.value = e.target.value;
}
let summaryEl = $('#article_summary')[0];
summaryEl.onchange = (e) => {
  let summaryDraftEl = $('#article_summary')[1];
  summaryDraftEl.value = e.target.value;
}
let imageEl = $("#uploading-image")[0];
imageEl.onchange = (e) => {
  console.log(imageEl);
  console.log(imageEl.value);
  console.log(e);
  console.log(e.target.files[0])
  console.log(this);
  
  // imageDraftEl = $("#hidden-uploaded-image")[0];
  // imageDraftEl.value = e.target.files[0];
}
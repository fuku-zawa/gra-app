// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import $ from 'jquery'
import axios from 'axios'

// いいねの設定
document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#post-get-id').data()
  const postId = dataset.postId

  axios.get(`/posts/${postId}/like`)
    .then((response) => {
      console.log(response)
    })
})
// 


$(() => {

  $('.edit-profile-avatar').on('click', () => {
    $("#avatar-edit-form").click()
  })

  $('#edit-profile').on('change', () => {
    $('#avatar-edit-button').click()
  })
  $('.show-profile-avatar').on('click', () => {
    $("#avatar-show-form").click()
  })

  $('#show-profile').on('change', () => {
    $('#avatar-show-button').click()
  })

  // アップする画像のプレビュー（posts/new）
  // file_fieldから選択されたファイルを読み込んで表示する
  $(document).ready(function() {
    // file_fieldの値（選択されたファイル）が変更されたときに実行するイベントハンドラ
    $('#post-photo').on('change', function() {
      // 選択したファイルthis（inputタグがそのまま入ってくる感じ？）を格納
      const preview = this

      for (let num=0; num < preview.files.length; num ++)
        //filesはinput要素のプロパティ（filesプロパティを持つfile_fieldから取得されたファイルの情報を格納）
        if (preview.files && preview.files[num]) {

          // ファイルの内容を非同期で読み込むAPIで、FileReaderオブジェクトを作成
          const reader = new FileReader()
          
          // onloadはファイルの読み込みが完了したら実行される関数
          // 読み込みは、readAsDataURLで実行されるので、先にそっちが実行される
          // ファイルを読み込んだら、#photo-previewに、src属性とcssの設定を変更する
          reader.onload = function(e) {
            // イベントが発生したHTML要素をevent.targetで取得する
            // fileReaderで読み込みできたら、resultプロパティで中身のデータ（Base64）を取得できる
            // appendにすることで、imgタグが追加できる（複数の場合もOK）
            $('#photo-preview').append('<div class= pre-wrap>')
            $('#photo-preview').append('<img src="' + e.target.result + '" alt="Image Preview" class= pre>')
            $('#photo-preview').css('display', 'block')
            $('.pre').css('max-width', '150px')
            $('.pre').css('max-height', 'auto')
          }
          // 指定されたファイルを非同期で読み込む（ないと、選択して非同期で読み込まない）
          
          reader.readAsDataURL(preview.files[num])

        }
    })
  })

})
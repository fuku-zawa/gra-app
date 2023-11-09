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

import {csrfToken} from "rails-ujs"
axios.defaults.headers.common["X-CSRF-Token"] = csrfToken()


document.addEventListener('DOMContentLoaded', () => {
  // いいね機能
  // .post-index-countがついた要素をすべて取得
  const postElements = document.querySelectorAll('.post-index-count')
  // postElementsはNodeListなので、array.fromで変換し、mapで配列を作成
  const elementId = Array.from(postElements).map(function(element){
    // postElementsの要素を順番に取り出し、innerHTMLがidの数字になっていたのでそれを返す
    return element.innerHTML
  })
  // elementIdは、 ['33', '34', '35', '36', '37', '38', '39']こんな感じ
  // ひとつずつ取り出して、axiosからリクエストを投げて判定して、hiddenクラスを取る
  elementId.forEach( postId =>{
    axios.get(`/posts/${postId}/like`)
      .then((response) => {
        const hasLiked = response.data.hasLiked
        if (hasLiked) {
          $(`.active-heart-${postId}`).removeClass('hidden')
        } else {
          $(`.inactive-heart-${postId}`).removeClass('hidden')
        }
      })
  })

  elementId.forEach( postId =>{
    $(`.active-heart-${postId}`).on('click', () => {
      axios.get(`/posts/${postId}/like`)
        .then((response) => {
          const hasLiked = response.data.hasLiked
          if (hasLiked) {
            $(`.active-heart-${postId}`).removeClass('hidden')
          } else {
            $(`.inactive-heart-${postId}`).removeClass('hidden')
          }
        })
    })
  
    
    $(`.active-heart-${postId}`).on('click', () => {
      axios.delete(`/posts/${postId}/like`)
        .then((response) => {
          if (response.data.status === 'ok' ) {
            $(`.active-heart-${postId}`).addClass('hidden')
            $(`.inactive-heart-${postId}`).removeClass('hidden')
          }
      })
    })

    $(`.inactive-heart-${postId}`).on('click', () => {
      axios.post(`/posts/${postId}/like`)
        .then((response) => {
          if (response.data.status === 'ok' ) {
            $(`.active-heart-${postId}`).removeClass('hidden')
            $(`.inactive-heart-${postId}`).addClass('hidden')
          }
        })
    })
  })
})

// コメントの表示→new.htmlのcomments-blockクラスに表示
document.addEventListener('DOMContentLoaded', () => {
  const dataset = $('#post-id').data()
  const postIdComment = dataset.postId

  // new.htmlからavatarを取得
  const avatarsClassName = document.getElementsByClassName("hidden-class-img")
  const avatars = []
  for (let i = 0; i < avatarsClassName.length; i++) {
    const avatarSrc = avatarsClassName[i].getAttribute("src")
    avatars.push(avatarSrc)
  }

  axios.get(`/posts/${postIdComment}/comments`)
    .then((response) => {
      const comments = response.data.map((data) => data.content)
      const names = response.data.map((data) => data.user_name)
      
      const commentsProfile = comments.map((comment, index) => [comment, names[index], avatars[index]])
      commentsProfile.forEach((profile) => {
        const comment = profile[0]
        const name = profile[1]
        const avatar = profile[2]
        const newComment = document.createElement('div')
        newComment.innerHTML = `
          <ul class="post-list comments-list">
            <li class="avatars-content">
              <img src="${avatar}" class="avatars-comment">
            </li>
            <div class="post-list-info">
              <li class="names-content">
                ${name}
              </li>
              <p class="comment-content">${comment}</p>
            </div>
          </ul>
        `
        const container = document.getElementById('comments-block')
        container.appendChild(newComment)
      })
  })

  // コメントの投稿

  $('.add-comment-button').on("click", () => {
    const content = $('#comment_content').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      // ストロングパラメータがあるので、第2引数に送信の形を指定する
      axios.post(`/posts/${postIdComment}/comments`, {comment: {content: content}} )
        .then((res) => {
          const commentRes = res.data
          $('.comments-content').append(`${commentRes.content}`)
          $('#comment_content').val('')
        })
    }
  })
})



// 新規投稿関係
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



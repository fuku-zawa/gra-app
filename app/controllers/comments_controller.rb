class CommentsController < ApplicationController
  def new
    # postを取得（コメントをしたい投稿のidをパラメータから取得）
    post = Post.find(params[:post_id])
    # ↑のpostから空のオブジェクトを作成→form_withからcreateアクションに送られる
    @comment = post.comments.build
  end

end
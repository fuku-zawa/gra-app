class CommentsController < ApplicationController
  def index
    post = Post.find(params[:post_id])
    comments = post.comments
    render json: comments
  end
  
  def new
    # postを取得（コメントをしたい投稿のidをパラメータから取得）
    @post = Post.find(params[:post_id])
    # ↑のpostから空のオブジェクトを作成→form_withからcreateアクションに送られる
    @comment = @post.comments.build
    # コメント表示用に@comments
    # @comments = @post.comments
    @comments = @post.comments.order(created_at: :asc)
  end

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    if @comment.save
      redirect_to new_post_comment_path(post), notice: "コメント追加"
    else
      flash.now[:error] = "保存できませんでした"
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
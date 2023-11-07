class CommentsController < ApplicationController
  
  # API
  # post_idを指定してindexにgetリクエストを送る
  def index
    # URLのidの投稿をpostに代入
    post = Post.find(params[:post_id])
    # その投稿のコメントをcommentsに（リスト）
    comments = post.comments

    render json: comments

  end


  # ビュー
  def new
    # postを取得（コメントをしたい投稿のidをパラメータから取得）
    @post = Post.find(params[:post_id])
    # ↑のpostから空のオブジェクトを作成→form_withからcreateアクションに送られる→createにあるからいらんのでは
    # @comment = @post.comments.build
    # # コメント表示用に@comments　※並び変えるとデータ形式が変わって、末尾のデータがなくなる
    # @comments = @post.comments.order(created_at: :asc)
    # コメントのユーザ名を取得
    # @user_names = @comments.map { |comment| comment.post.user.name }
    # @user_avatar = @comments.map { |comment| comment.post.user.avatar}

    # @post.commentsで、コメントを取得できれば↓は不要
    # @post_comment = @post.comments.where(post_id:params[:post_id])
    @post_comment = @post.comments
    @comment_avatar = @post.comments.map {|comment| comment.user.avatar }
    
  end

  def create
    @post = Post.find(params[:post_id])
  
    @comment = @post.comments.build(comment_params)

    # user_idを渡すようにする
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to new_post_comment_path(@post), notice: "コメント追加"
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
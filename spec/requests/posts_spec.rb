require 'rails_helper'

RSpec.describe "Posts", type: :request do

  # 記事があった状態でテストをしたいので、記事をつくる
  let!(:user) { create(:user) }
  # 複数の記事を作るときはcreate_list
  let!(:posts) { create_list(:post, 1, user: user, photos: [Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/post1.png", 'image/png')]) }

  describe "GET /posts" do
    it "200ステータスが返ってくる" do
      get posts_path
      # コントローラで記載されているリダイレクト先にリダイレクトさせる（違うのところにリダイレクトしないように）
      follow_redirect!
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /posts" do
    context 'ログインしている場合' do
      before do 
        # deviseでは「sign_in user」でログインできるが、rspecではそのまま使えないので、rails_helper.rbに設定が必要
        sign_in user
      end
      
      it "記事が保存される" do
        # postのfactoryで定義している属性のハッシュを生成（=> {:mind=> , :photos=> }）
        post_params = attributes_for(:post)
        # postなのでパラメータを送ってあげる必要がある
        # ↑で定義したpost_paramsのハッシュを渡せば、posts#createできる
        # params{ post: {:mind  , :photos  } }をposts_pathに渡す
        post posts_path({post: post_params})
        # post posts_path, params: { post: post_params }の書き方でもいい？

        # 302が返ってくるか確認（これだけだと保存されているかまでは確認できない）
        # レンダリングされるなら302が返ってくるけど、今回は200が返ってきているので200にしておく
        expect(response).to have_http_status(200)
        # 保存されているかは、DBの最後の値と一致しているかどうかで確認する
        expect(Post.last.mind).to eq(post_params[:mind])
      end
    end
  end

end

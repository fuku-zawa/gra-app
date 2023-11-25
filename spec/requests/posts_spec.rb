require 'rails_helper'

RSpec.describe "Posts", type: :request do

  # 記事があった状態でテストをしたいので、記事をつくる
  let!(:user) { create(:user) }
  # 複数の記事を作るときはcreate_list
  let!(:posts) { create_list(:post, 5, user: user, photos: [Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/post1.png", 'image/png')]) }
  
  describe "GET /posts" do
    it "200ステータスが返ってくる" do
      get posts_path
      # コントローラで記載されているリダイレクト先にリダイレクトさせる（違うのところにリダイレクトしないように）
      follow_redirect!
      expect(response).to have_http_status(200)
    end
  end
end

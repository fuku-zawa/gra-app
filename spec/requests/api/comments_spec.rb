require 'rails_helper'

RSpec.describe "Api::Comments", type: :request do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user, photos: [Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/post1.png", 'image/png')]) }
  let!(:comments) { create_list(:comment, 3, post: post, user: user )}

  describe "GET /api/comments" do
    before do
      sign_in user
    end

    it "200 Status" do
      get post_comments_path(post_id: post.id)
      expect(response).to have_http_status(200)

      # apiの場合、responseがJSONで返ってくるので細かくチェックできる
      body = JSON.parse(response.body)
      expect(body.length).to eq 3
      expect(body[0]['content']).to eq comments.first.content
      expect(body[1]['content']).to eq comments.second.content
      expect(body[2]['content']).to eq comments.third.content
    end
  end
end
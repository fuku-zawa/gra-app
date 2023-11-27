require 'rails_helper'

RSpec.describe 'Post', type: :system do
  before do
    # Capybaraのドライバー設定を変更する
    driven_by :selenium, using: :headless_chrome

    sign_in user
  end

  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 3, user: user, photos: [Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/post1.png", 'image/png')])}

  it '記事一覧が表示される' do
    visit root_path
    posts.each do |post|
      # ページにpost.mindがあるかどうか→イメージ通りにpost.mindがあるかまではわからない
      # expect(page).to have_content(post.user.name)
      # より正確にするにはhave_css
      expect(page).to have_css('.post-list-info', text: post.user.name)
    end
  end

  it '投稿一覧からアバターをクリックするとユーザのプロフィール画面に遷移する' do
    visit root_path
    post = posts.first
    # post/indexのアバターにaltを追加、最初にマッチするaltをクリックする
    click_on "system-spec", match: :first
    expect(page).to have_css('.profile-top-username', text: post.user.name)
  end

end
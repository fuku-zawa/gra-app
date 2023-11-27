require 'rails_helper'

RSpec.describe 'Post', type: :system do
  before do
    # Capybaraのドライバー設定を変更する
    driven_by :selenium, using: :headless_chrome
  end

  it '記事一覧が表示される' do
    visit root_path
  end
end
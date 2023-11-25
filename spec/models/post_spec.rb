require 'rails_helper'

RSpec.describe Post, type: :model do
  # バリデーションが機能しているか確認する

  # :userのシンボルは、factorybotのuser
  let!(:user) { create(:user) }

  context 'mindが空の場合' do  
    let!(:post) { build(:post, mind: '', user: user)}

    before do
      post.save
    end

    it '保存に失敗する' do
      expect(post.errors.messages[:mind][0]).to eq('を入力してください')  
      
    end
  end
end

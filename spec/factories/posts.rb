FactoryBot.define do
  factory :post do
    # mind { Faker::Lorem.characters(number: 10)  }
    mind { 'これはテストなんだよ' }
    photos { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/post1.png", 'image/png') }
  end
end
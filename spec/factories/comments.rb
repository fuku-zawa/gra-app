FactoryBot.define do
  factory :comment do
    # photos { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/post1.png", 'image/png') }
    # name { Faker::Name.first_name }
    content { Faker::Lorem.characters(number: 10) }
  end
end
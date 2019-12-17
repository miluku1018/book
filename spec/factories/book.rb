FactoryBot.define do
  factory :book do
   title      { Faker::Name.name }
   list_price { [*10..1000].sample } #Faker::Number.between(from: 1, to: 10)
   sell_price { [*10..1000].sample }
   page_num   { [*100..500].sample }
   isbn       { SecureRandom.hex(5).upcase }
   isbn13     { SecureRandom.hex(6).upcase }

   publisher
   category
  end
end
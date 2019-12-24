FactoryBot.define do
  factory :order do
    user { nil }
    recipient { "MyString" }
    tel { "MyString" }
    address { "MyString" }
    note { "MyText" }
    state { "MyString" }
    num { "MyString" }
  end
end

FactoryBot.define do
    factory :profile do
        first_name { "John" }
        last_name { "Kim" }
        bio { "Hello" }
        association :user
    end
end

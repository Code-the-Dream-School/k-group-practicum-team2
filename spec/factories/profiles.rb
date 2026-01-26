FactoryBot.define do
    factory :profile do
        first_name { "John" }
        last_name { "Kim" }
        bio { "Hello" }
        skill_level { "junior" }
        association :user
    end
end

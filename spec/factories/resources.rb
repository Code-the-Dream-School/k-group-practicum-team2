FactoryBot.define do
    factory :resource do
        description { "description" }
        title { "title" }
        url { "https://examples" }
        association :user
    end
end

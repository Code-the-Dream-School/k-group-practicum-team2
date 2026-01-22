FactoryBot.define do
    factory :project do
        description { "project description" }

        title { "project title" }
        association :user
    end
end

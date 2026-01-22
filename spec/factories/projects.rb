FactoryBot.define do
    factory :project do
        description { "project description" }
        tech_stack { "tech stack" }
        title { "project title" }
        association :user
    end
end

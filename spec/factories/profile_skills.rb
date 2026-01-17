FactoryBot.define do
    factory :profile_skill do
        association :profile
        association :skill
    end
end

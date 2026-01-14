FactoryBot.define do
    factory :bookmarked_resource do
        association :user
        association :resource
    end
end

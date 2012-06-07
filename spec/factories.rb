FactoryGirl.define do
  factory :celebrity do
    sequence(:uid) { |n| n }
    sequence(:domain) { |n| "arang_#{n}"}
  end
end

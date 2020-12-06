require 'faker'

FactoryBot.define do
  factory :party do
    user
    movie_title { Faker::Movie.title }
    duration { Faker::Number.number(digits: 3).to_s }
    date { '12/20/2020' }
    start_time { '10:00' }
  end
end

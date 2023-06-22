# frozen_string_literal: true

FactoryBot.define do
  factory :shift do
    association :worker
    start_time { Time.zone.parse('2023-06-22 08:00:00') }
    end_time { Time.zone.parse('2023-06-22 16:00:00') }
  end
end

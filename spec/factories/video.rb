FactoryGirl.define do
  factory :video do
    association :user
    start_time 5
    end_time 10
    status 'scheduled'
    video { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'videos', 'test_video.mp4'), 'video/mp4') }

    trait :done do
      status 'done'
    end

    trait :failed do
      status 'failed'
    end
  end
end

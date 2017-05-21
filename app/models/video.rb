class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :processing_delay

  ALLOWED_STATUSES = %w(done failed scheduled processing)

  mount_uploader :video, VideoUploader

  field :duration
  field :start_time
  field :end_time
  field :status

  belongs_to :user, inverse_of: :videos

  validates :status, inclusion: { in: ALLOWED_STATUSES }, allow_nil: true
  validates :video, presence: true
  validate  :duration_correctness

  before_create :trim_video

  def url
    done? ? video.url.sub(/\.(.*)\z/, '') + '_trimmed.' + $1 : video.url
  end

  def name
    video.file.filename
  end

  ALLOWED_STATUSES.each do |status|
    define_method "#{status}?" do
      self.status == status
    end

    define_method "#{status}!" do
      self.update_attribute(:status, status)
    end
  end

  private

  def duration_correctness
    if start_time.to_i > end_time.to_i || start_time.to_i < 0
      errors.add(:start_time, "can't be negative or greater than end_time")
    end
  end

  def trim_video
    Processors::VideoTrimmer.new(self, processing_delay).trim_video
  end
end

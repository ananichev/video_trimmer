class Video
  include Mongoid::Document
  mount_uploader :video, VideoUploader
  field :duration, type: Integer
  field :status, type: String
  validates :status, inclusion: { in: %w(done failed scheduled processing) }
end

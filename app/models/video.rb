class Video
  include Mongoid::Document
  mount_uploader :data, VideoUploader
end

module Processors
  class VideoTrimmer < Struct.new(:video, :options)
    def call
      video.status = 'scheduled'
      TrimVideoJob.perform_later(video.id.to_s, options)
    end
  end
end

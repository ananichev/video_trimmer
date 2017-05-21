module Processors
  class VideoTrimmer < Struct.new(:video, :processing_delay)
    def trim_video
      current_path = Rails.root.join('public', video.video.store_path).to_s
      new_path = current_path.sub(/\.(.*)\z/, '') + '_trimmed.' + $1

      video.status = 'scheduled'
      TrimVideoJob.perform_later(current_path, new_path, video.id.to_s, processing_delay)
    end
  end
end

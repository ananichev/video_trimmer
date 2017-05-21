class TrimVideoJob < ApplicationJob
  queue_as :default

  def perform(current_path, new_path, model_id, processing_delay)
    model = Video.find(model_id)
    model.processing!
    sleep processing_delay.to_i
    model.duration = model.end_time.to_i - model.start_time.to_i
    ffmpeg = FFMPEG::Movie.new(current_path)
    ffmpeg.transcode(new_path, ['-ss', model.start_time.to_s, '-t', model.duration.to_s])
    model.done!
  rescue => e
    puts "Something went wrong! #{e.message}"
    puts e.backtrace
    model.failed!
  end
end

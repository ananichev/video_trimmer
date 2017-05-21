class TrimVideoJob < ApplicationJob
  queue_as :default

  def perform(model_id, options = {})
    model = Video.find(model_id)
    current_path = Rails.root.join('public', model.video.path).to_s
    new_path = current_path.sub(/\.(.*)\z/, '') + '_trimmed.' + $1
    model.processing!

    raise StandardError if options[:force_error] == 'true'
    sleep options[:processing_delay].to_i

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

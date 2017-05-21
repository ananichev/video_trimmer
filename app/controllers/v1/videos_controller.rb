module V1
  class VideosController < BaseApiController
    before_action :find_video, only: [:show, :retry]

    def index
      @videos = current_user.videos
    end

    def create
      @video = current_user.videos.build(video_params)
      @video.processing_delay = params[:processing_delay]
      @video.force_error = params[:force_error]
      @video.save ? render(:show) : render_error(@video.errors.full_messages)
    end

    def show
    end

    def retry
      @video.retry!
      render :show
    end

    private

    def find_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:video, :start_time, :end_time)
    end
  end
end

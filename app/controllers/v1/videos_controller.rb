module V1
  class VideosController < BaseApiController
    def index
      @videos = current_user.videos
    end

    def create
      @video = current_user.videos.build(video_params)
      @video.save ? render(:show) : render_error(@video.errors.full_messages)
    end

    def show
      @video = Video.find(params[:id])
    end

    private

    def video_params
      params.require(:video).permit(:video, :start_time, :end_time)
    end
  end
end

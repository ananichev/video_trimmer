module V1
  class VideosController < ApplicationController
    def index
    end

    def new
    end

    def create
      video = Video.new(video_params)

      if video.valid? && video.save
        render json: { status: :ok }
      else
        render json: { errors: video.errors.full_messages }, status: 422
      end
    end

    def show
      # video: video.as_json(only: [:duration, :status], methods: :url)
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def video_params
      params.require(:video).permit(:video, :start_time, :end_time)
    end
  end
end

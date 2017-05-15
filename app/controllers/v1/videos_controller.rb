module V1
  class VideosController < ApplicationController
    def index
    end

    def new
    end

    def create
      video = Video.new(duration_params)
      video.video = video_param
      video.save

      respond_to do |format|
        format.json { render json: { status: :ok } }
      end
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def video_param
      params.require(:video).permit(:video)[:video]
    end

    def duration_params
      params.require(:video).permit(:start_time, :end_time)
    end
  end
end

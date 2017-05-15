module CarrierWaveProcessors
  module VideoTrimmer
    extend ActiveSupport::Concern

    class_methods do
      def trim_video
        process :trim_video
      end
    end

    def trim_video
      byebug
    end
  end
end

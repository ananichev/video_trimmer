json.video do
  json.status   @video.status
  json.url      @video.url
  json.name      @video.name
  json.duration @video.duration
end

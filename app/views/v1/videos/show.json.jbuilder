json.video do
  json.id       @video.id.to_s
  json.status   @video.status
  json.url      @video.url
  json.name     @video.name
  json.duration @video.duration
end

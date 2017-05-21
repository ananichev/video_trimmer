$(document).ready(function() {
  var videoItem = function(video) {
    var button;

    if (video.status === 'failed') {
      button = '| <button name="button" type="submit" class="great_button"' +
               ' data-url="http://localhost:3000/v1/videos/'+ video.id + '/retry.json' +
               '">Retry</button>'
    } else {
      button = '| <button name="button" type="submit" class="great_button"' +
               ' data-url="http://localhost:3000/v1/videos/'+ video.id + '.json">Update status</button>'
    }

    return('<li><a href="' + video.url + '">' + video.name + '</a>| '
           + video.status + '| ' + video.duration + button + '</li>')
  }

  $('#new_video').on('submit', function() {
    var $this = $(this),
        formData = new FormData(this);

    $.ajax({
      url: $this.attr('action'),
      data: formData,
      processData: false,
      contentType: false,
      type: 'POST'
    }).done(function(response) {
      $('#response').hide().text(JSON.stringify(response)).fadeIn('slow').delay(3000).hide(1);
      $('#video_list ul').append(videoItem(response.video))
    }).fail(function(response) {
      $('#response').hide().text(response.responseText).fadeIn('slow').delay(3000).hide(1)
    });

    return false
  });

  $('#video_list').on('click', '.great_button', function() {
    var $this = $(this);

    $.get($this.data('url'), { token: 'simple_token' }).done(function(response) {
      $this.parent().replaceWith(videoItem(response.video))
    })
  })
});

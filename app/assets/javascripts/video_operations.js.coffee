class @VideoOperations
  @currentVideo;

  constructor: (player) ->
    @player = player

  currentQueue: (button, youtube_id, title) ->
    $.ajax (
      type: "GET"
      url: "/jukebox"
      success: (data, textStatus, jqXHR) ->
        $('#queue').html(data)
    )

  playNext: () ->
    $.ajax (
      type: "GET"
      url: "/play"
      contentType: "application/json",
      success: (data, textStatus, jqXHR) =>
        if data
          @currentVideo = data

          @player.src('http://www.youtube.com/watch?v=' + data.youtube_video.youtube_id);
          @player.play();

          @player.show();
          $('#empty-queue').addClass('hidden');
        else
          $('#empty-queue').removeClass('hidden');
          @player.hide();
    )

  pause: () ->
    $.ajax (
      type: "PUT"
      url: "/videos/" + @currentVideo.youtube_id + "/pause"
      contentType: "application/json"
    )

  continue: () ->
    $.ajax (
      type: "PUT"
      url: "/videos/" + @currentVideo.youtube_id + "/continue"
      contentType: "application/json"
    )

  setCurrentTime: (currentTime) ->
    $.ajax (
      type: "PUT"
      url: "/videos/" + @currentVideo.youtube_id + "/current_time"
      data: JSON.stringify({current_time: currentTime})
      contentType: "application/json"
    )

  @addLoading: ($node) ->
    $search_icon = $node.find(".glyphicon-search")
    $search_load_icon = $node.find(".loading-indicator")

    $search_icon.addClass("hidden")
    $search_load_icon.removeClass("hidden")

  @removeLoading: ($node) ->
    $search_icon = $node.find(".glyphicon-search")
    $search_load_icon = $node.find(".loading-indicator")

    $search_icon.removeClass("hidden")
    $search_load_icon.addClass("hidden")

  @disable: ($button, text) ->
    $button.text(text) if text
    $button.addClass("disabled")
    $button.attr("disabled", "disabled")

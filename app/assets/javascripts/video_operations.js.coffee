class @VideoOperations

  @addToQueue: (button, youtube_id, title) ->
    $button = $(button)
    $.ajax (
      type: "POST"
      url: $button.attr("href")
      data: { youtube_id: youtube_id, title: title }
      success: ->
        VideoOperations.disable($button, "Added")
    )

  @currentQueue: (button, youtube_id, title) ->
    $.ajax (
      type: "GET"
      url: "/queued_videos"
      success: (data, textStatus, jqXHR) ->
        $('#queue').html(data)
    )

  @playNext: (youtube_player) ->
    $.ajax (
      type: "GET"
      url: "/play"
      contentType: "application/json",
      success: (data, textStatus, jqXHR) ->
        if data.video
          youtube_service = new YoutubeService(youtube_player)
          youtube_service.play(data.video)
        else
          location.reload()
    )

  @addToFavorites: (button, youtube_id, title) ->
    $button = $(button)
    $.ajax (
      type: "POST"
      url: $button.attr("href")
      data: { youtube_id: youtube_id, title: title }
      success: ->
        VideoOperations.disable($button, "")
        $button.find("span:first-child").removeClass("glyphicon-star-empty").addClass("glyphicon-star")
    )

  @removeFromFavorites: (button, youtube_id) ->
    $button = $(button)
    $.ajax (
      type: "DELETE"
      url: $button.attr("href")
      data: { youtube_id: youtube_id }
      success: ->
        VideoOperations.disable($button, "")
        $button.find("span:first-child").removeClass("glyphicon-star").addClass("glyphicon-star-empty")
    )

  @disable: ($button, text) ->
    $button.text(text) if text
    $button.addClass("disabled")
    $button.attr("disabled", "disabled")

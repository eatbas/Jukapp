class @VideoOperations

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

  @addLoading: ($form) ->
    $search_icon = $form.find(".glyphicon-search")
    $search_load_icon = $form.find(".loading-indicator")

    $search_icon.addClass("hidden")
    $search_load_icon.removeClass("hidden")

  @removeLoading: ($form) ->
    $search_icon = $form.find(".glyphicon-search")
    $search_load_icon = $form.find(".loading-indicator")

    $search_icon.removeClass("hidden")
    $search_load_icon.addClass("hidden")

  @disable: ($button, text) ->
    $button.text(text) if text
    $button.addClass("disabled")
    $button.attr("disabled", "disabled")

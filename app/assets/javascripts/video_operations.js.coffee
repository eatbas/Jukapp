class @VideoOperations

  @currentQueue: (button, youtube_id, title) ->
    $.ajax (
      type: "GET"
      url: "/queued_videos"
      success: (data, textStatus, jqXHR) ->
        queue = $.map data, (queuedVideo) ->
          id: queuedVideo.id
          title: queuedVideo.video.title
          length: queuedVideo.video.length
        document.querySelector("jukapp-scaffold").queue = queue
    )

  @deleteQueuedVideo: (id) ->
    $.ajax (
      type: "DELETE"
      url: "/queued_videos/" + id
    )

  @playNext: () ->
    $.ajax (
      type: "GET"
      url: "/play"
      contentType: "application/json",
      success: (data, textStatus, jqXHR) ->
        if data.video
          video = data.video
          $("#youtube_player").attr("videoid", video.youtube_id)
          $("#video_title").text(video.title)
        else
          location.reload()
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

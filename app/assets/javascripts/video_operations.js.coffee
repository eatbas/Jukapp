class @VideoOperations

  @currentQueue: () ->
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

          if $("jukapp-player").attr("youtubeId") == video.youtube_id
            # VideoOperations.playNext()
          else
            $("jukapp-player").attr("youtubeId", video.youtube_id)

          $("jukapp-player").attr("videoTitle", video.title)
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

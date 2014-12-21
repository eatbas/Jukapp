class @VideoOperations

  @search: (query) ->
    return if query == ""
    $.ajax(
      type: "GET"
      url: "/ajax_search"
      data: {query: query}
      success: (data, textStatus, jqXHR) ->
        $("#search-tab").show();
        paperTabs = document.querySelector("paper-tabs")
        paperTabs.selected = paperTabs.childElementCount - 1
        $("#search-tab-content").html(data)
    )

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

          $("#page-title").html(video.title)
        else
          $("jukapp-player").attr("youtubeId", '')
          $("#page-title").html("Empty Queue")
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

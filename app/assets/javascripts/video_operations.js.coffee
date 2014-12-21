class @VideoOperations

  @fetchTab: (url, node) ->
    $.ajax(
      type: "GET"
      url: url
      success: (data, textStatus, jqXHR) ->
        $(node).html(data)
    )

  @fetchActiveTab: () ->
    selectedTab = $("paper-tab.core-selected")
    selectedTab.attr("page", "")
    tabUrl = selectedTab.attr("tabUrl")
    if tabUrl
      tabContentId = "#" + selectedTab.attr("id") + "-content"
      this.fetchTab(tabUrl, tabContentId)

  @search: (query) ->
    return if query == ""

    $("#search-tab").show();
    paperTabs = document.querySelector("paper-tabs")
    paperTabs.selected = paperTabs.childElementCount - 1
    VideoOperations.addLoading();

    $.ajax(
      type: "GET"
      url: "/ajax_search"
      data: {query: query}
      success: (data, textStatus, jqXHR) ->
        VideoOperations.removeLoading();
        $("#search-tab-content").html(data)
    )

  @currentQueue: () ->
    $.ajax (
      type: "GET"
      url: "/queued_videos"
      success: (data, textStatus, jqXHR) ->
        VideoOperations.fetchActiveTab()
        queue = $.map data, (queuedVideo) ->
          id: queuedVideo.id
          title: queuedVideo.video.title
          length: queuedVideo.video.length
        document.querySelector("jukapp-scaffold").queue = queue
    )

  @fetchNextPage: () ->
    selectedTab = $("paper-tab.core-selected")
    paginated = selectedTab.attr("paginated")
    currentPage = selectedTab.attr("page")
    return if currentPage == "last" or !paginated

    currentPage = 1 if !currentPage or currentPage == ""
    nextPage    = parseInt(currentPage) + 1

    this.addPaginationLoading()
    $.ajax (
      type: "GET"
      url: "/recents?page=" + nextPage
      success: (data, textStatus, jqXHR) ->
        tabContentId = "#" + selectedTab.attr("id") + "-content"
        if data.trim() == ""
          selectedTab.attr("page", "last")
          VideoOperations.removePaginationLoading();
        else
          selectedTab.attr("page", nextPage)
          $(tabContentId).append(data)
          VideoOperations.removePaginationLoading();
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
        VideoOperations.fetchActiveTab()
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

  @addLoading: () ->
    $("#main-loading-indicator").addClass("fixed-top")
    $("#main-loading-indicator").show()

  @removeLoading: () ->
    $("#main-loading-indicator").removeClass("fixed-top")
    $("#main-loading-indicator").hide()

  @addPaginationLoading: () ->
    if document.querySelector("jukapp-scaffold").narrow
      $("#main-loading-indicator").addClass("narrow")
    $("#main-loading-indicator").addClass("fixed-bottom")
    $("#main-loading-indicator").show()

  @removePaginationLoading: () ->
    $("#main-loading-indicator").removeClass("narrow")
    $("#main-loading-indicator").removeClass("fixed-bottom")
    $("#main-loading-indicator").hide()

  @disable: ($button, text) ->
    $button.text(text) if text
    $button.addClass("disabled")
    $button.attr("disabled", "disabled")

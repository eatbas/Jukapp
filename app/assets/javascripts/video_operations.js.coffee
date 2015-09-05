class @VideoOperations

  @currentQueue: (button, youtube_id, title) ->
    $.ajax (
      type: "GET"
      url: "/queued_videos"
      success: (data, textStatus, jqXHR) ->
        $('#queue').html(data)
    )

  @playNext: (player) ->
    $.ajax (
      type: "GET"
      url: "/play_new"
      contentType: "application/json",
      success: (data, textStatus, jqXHR) ->
        console.log(data)
        if data
          player.src('http://www.youtube.com/watch?v=' + data.youtube_id);
          player.play();
        else
          $('#empty-queue').removeClass('hidden');
          console.log($('#empty-queue'))
          player.hide();
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

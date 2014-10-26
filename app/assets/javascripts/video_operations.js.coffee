class @VideoOperations

  @addToQueue: (button, youtube_id, title) ->
    $button = $(button)
    $.ajax (
      type: "POST"
      url: $button.attr("data-href")
      data: { youtube_id: youtube_id, title: title }
      success: () ->
        @disable($button, "Added")
    )

  @addToFavorites: (button, youtube_id, title) ->
    $button = $(button)
    $.ajax (
      type: "POST"
      url: $button.attr("href")
      data: { youtube_id: youtube_id, title: title }
      success: () ->
        VideoOperations.disable($button)
    )

  @removeFromFavorites: (button, youtube_id) ->
    $button = $(button)
    $.ajax (
      type: "DELETE"
      url: $button.attr("href")
      data: { youtube_id: youtube_id }
      success: () ->
        VideoOperations.disable($button)
    )

  @disable: ($button, text) ->
    button.text(text) if text
    $button.addClass("disabled")
    $button.attr("disabled", "disabled")

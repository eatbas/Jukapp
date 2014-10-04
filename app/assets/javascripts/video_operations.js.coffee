class @VideoOperations

  @addToQueue: (form, button) ->
    $.ajax (
      type: "POST"
      url: form.attr('action')
      data: form.serialize()
      success: () ->
        button.text("Added")
        button.addClass("disabled")
        button.attr("disabled", "disabled")
    )

  @addToFavorites: (form, button) ->
    $.ajax (
      type: "POST"
      url: form.attr('action')
      data: form.serialize()
      success: () ->
        button.addClass("disabled")
        button.attr("disabled", "disabled")
    )

  @removeFromFavorites: (form, button) ->
    $.ajax (
      type: "DELETE"
      url: form.attr('action')
      data: form.serialize()
      success: () ->
        button.addClass("disabled")
        button.attr("disabled", "disabled")
    )
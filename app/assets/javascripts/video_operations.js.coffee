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

#= require jquery
#= require jquery_ujs
#= require webcomponentsjs/webcomponents
#= require_tree .

ajaxMessage = (msg, type) ->
  $("#flash-message").html("<paper-toast class='capsule toast-message' text='#{msg}'></paper-toast>")
  $("#flash-message").bind("click.dismissToast", ->
    this.dismiss()
  )
  $("#flash-message").show()

$(document).ajaxComplete (event, request) ->
  msg = request.getResponseHeader("X-Toast")
  type = request.getResponseHeader("X-Toast-Type")
  ajaxMessage(msg, type)

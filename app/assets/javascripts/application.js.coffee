#= require webcomponentsjs/webcomponents
#= require jquery
#= require jquery_ujs
#= require fastclick
#= require_tree .

ajaxMessage = (msg, type) ->
  $("#flash-message").html("<paper-toast class='capsule toast-message' text='#{msg}' onclick='this.dismiss();'></paper-toast>")
  $(".toast-message")[0].show()

$(document).ajaxComplete (event, request) ->
  msg = request.getResponseHeader("X-Toast")
  type = request.getResponseHeader("X-Toast-Type")
  if msg != null
    ajaxMessage(msg, type)

$ ->
  new FastClick(document.body)

  document.querySelector("jukapp-scaffold").addEventListener "bottom-reached", (e) ->
    VideoOperations.fetchNextPage()

  $(".form-submit").click ->
    $(this).closest("form").submit()

  document.querySelector("jukapp-scaffold").addEventListener "search", (e) ->
    VideoOperations.search(e.detail.query)

  document.querySelector("paper-tabs").addEventListener "core-select", (e) ->
    $("#" + e.detail.item.getAttribute("id") + "-content").toggle(e.detail.isSelected)
    if e.detail.isSelected
      VideoOperations.fetchActiveTab()

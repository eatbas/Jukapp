context = {}
$ ->
  Twine.reset(context).bind().refresh()
  return

$(document).ajaxComplete ->
  Twine.refresh()

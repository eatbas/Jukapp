context = {}
$ ->
  Twine.reset(context).bind().refresh()
  return

$(document).ajaxComplete ->
  context = {}
  Twine.reset(context).bind().refresh()

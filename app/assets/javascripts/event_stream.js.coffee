jQuery ($) ->
  forPlayer: (currentVideo, player) ->
    @eshq.onmessage = (e) ->
      data = JSON.parse(e.data)
      switch data.operation
        when "next"
          VideoOperations.playNext(player)
        when "new"
          if currentVideo
            VideoOperations.currentQueue()
          else
            location.reload()
        when "play", "delete"
          VideoOperations.currentQueue()

  forQueue = (message) ->
    $("#queueHeader").removeClass("hidden")
    data = JSON.parse(message.data)
    switch data.operation
      when "next", "new", "play", "delete"
        VideoOperations.currentQueue()

  retries = 0
  listenToEventSource = (url) ->
    source = new EventSource(url)
    source.addEventListener 'queue', forQueue
    interval = setInterval ->
      switch source.readyState
        when source.CLOSED
          clearInterval(interval)
          if retries > 0
            retries -= 1
            listenToEventSource(url)
        else
          retries = 2
    , 30000

  $('[data-event-stream]').each ->
    listenToEventSource($(this).data('event-stream'))

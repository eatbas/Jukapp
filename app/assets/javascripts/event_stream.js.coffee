class @EventStream

  constructor: (url) ->
    @url = url

  retries = 0
  listenToEventSource: (url, operation) ->
    source = new EventSource(url)
    source.addEventListener 'queue', operation
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


  forPlayer: (currentVideo, player) ->
    this.listenToEventSource(@url, (message) ->
      data = JSON.parse(message.data)
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
    )

  forQueue: ->
    this.listenToEventSource(@url, (message) ->
      $("#queueHeader").removeClass("hidden")
      data = JSON.parse(message.data)
      switch data.operation
        when "next", "new", "play", "delete"
          VideoOperations.currentQueue()
    )

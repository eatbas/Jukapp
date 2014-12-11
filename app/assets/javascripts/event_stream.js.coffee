class @EventStream

  constructor: (room_id, pusher_key) ->
    pusher  = new Pusher(pusher_key)
    @channel = pusher.subscribe("queue-#{room_id}")

  forPlayer: (currentVideo) ->
    @channel.bind "next", () ->
      VideoOperations.playNext()
    @channel.bind "new", () ->
      if currentVideo
        VideoOperations.currentQueue()
      else
        location.reload()
    @channel.bind "play", () ->
      VideoOperations.currentQueue()
    @channel.bind "delete", () ->
      VideoOperations.currentQueue()

  forQueue: ->
    @channel.bind "next", () ->
      $("#queueHeader").removeClass("hidden")
      VideoOperations.currentQueue()
    @channel.bind "new", () ->
      $("#queueHeader").removeClass("hidden")
      VideoOperations.currentQueue()
    @channel.bind "play", () ->
      $("#queueHeader").removeClass("hidden")
      VideoOperations.currentQueue()
    @channel.bind "delete", () ->
      $("#queueHeader").removeClass("hidden")
      VideoOperations.currentQueue()

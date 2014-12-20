class @EventStream

  constructor: (room_id, pusher_key) ->
    pusher  = new Pusher(pusher_key)
    @channel = pusher.subscribe("queue-#{room_id}")

  forPlayer: (currentVideo) ->
    @channel.bind "next", () ->
      VideoOperations.playNext()
    @channel.bind "new", () ->
      VideoOperations.playNext()
    @channel.bind "play", () ->
      VideoOperations.currentQueue()
    @channel.bind "delete", () ->
      VideoOperations.currentQueue()

  forQueue: ->
    @channel.bind "next", () ->
      VideoOperations.currentQueue()
    @channel.bind "new", () ->
      VideoOperations.currentQueue()
    @channel.bind "play", () ->
      VideoOperations.currentQueue()
    @channel.bind "delete", () ->
      VideoOperations.currentQueue()

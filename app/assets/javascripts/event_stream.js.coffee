class @EventStream

  constructor: (room_id, socket_path, csrf_token) ->
    @eshq = new ESHQ("queue-#{room_id}", { auth_url: socket_path, auth_headers: {'X-CSRF-Token': csrf_token} })

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
        when "play"
          VideoOperations.currentQueue()

  forQueue: ->
    @eshq.onmessage = (e) ->
      $("#queueHeader").removeClass("hidden")
      data = JSON.parse(e.data)
      switch data.operation
        when "next"
          VideoOperations.currentQueue()
        when "new"
          VideoOperations.currentQueue()
        when "play"
          VideoOperations.currentQueue()

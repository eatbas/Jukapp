class @EventStream

  constructor: (room_id, socket_path, csrf_token) ->
    @eshq = new ESHQ("queue-#{room_id}", { auth_url: socket_path, auth_headers: {'X-CSRF-Token': csrf_token} })

  forPlayer: (currentVideo) ->
    @eshq.onmessage = (e) ->
      data = JSON.parse(e.data)
      if data.operation == "next" || ( data.operation == "new" && !currentVideo )
        location.reload()

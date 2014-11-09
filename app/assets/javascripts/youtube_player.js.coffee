class @YoutubePlayer

  constructor: (video) ->
    @player = new YT.Player("player",
      height: "390"
      width: "640"
      videoId: video
      events:
        onReady: onPlayerReady
        onStateChange: onPlayerStateChange
        onError: onPlayerError
    )

  onPlayerReady = (event) ->
    event.target.playVideo()

  onPlayerStateChange = (event) ->
    if event.data == 0
      VideoOperations.playNext()

  onPlayerError = (event) ->
    VideoOperations.playNext()

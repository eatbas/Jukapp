class @YoutubeService

  constructor: (@player) ->

  play: (youtube_id) ->
    @player.loadVideoById(youtube_id)

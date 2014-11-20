class @YoutubeService

  constructor: (@player) ->

  play: (video) ->
    @player.loadVideoById(video.youtube_id)
    $("#video_title").text(video.title)

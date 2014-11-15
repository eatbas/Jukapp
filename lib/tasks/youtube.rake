namespace :youtube do
  desc "Get youtube ids from playlist"
  task list: :environment do
    raise unless ENV['LIST_ID']

    puts YoutubeService.fetch_youtube_ids(ENV['LIST_ID'])
  end
end

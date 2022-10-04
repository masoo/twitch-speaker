require "dotenv/load"
require_relative "./lib/irc"

twitch_username = ENV.fetch("TWITCH_USERNAME")
twitch_token = ENV.fetch("TWITCH_OAUTH_TOKEN")
aws_region = ENV.fetch("AWS_REGION", "ap-northeast-1")
aws_access_key_id = ENV.fetch("AWS_ACCESS_KEY_ID")
aws_secret_access_key = ENV.fetch("AWS_SECRET_ACCESS_KEY")
begin
  puts "starting..."
  irc = Irc.new
  irc.activate(
    twitch_username: twitch_username,
    twitch_token: twitch_token,
    aws_region: aws_region,
    aws_access_key_id: aws_access_key_id,
    aws_secret_access_key: aws_secret_access_key
  )
  irc.stream_messages
  irc.run!
rescue Interrupt
  puts "closing..."
  irc.quit
end

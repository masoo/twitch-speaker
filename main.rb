require_relative "./lib/irc"
require_relative "./lib/settings"

settings = Settings.new
settings.load_json(path: "./settings.json")
begin
  puts "starting..."
  irc = Irc.new
  irc.activate(
    twitch_username: settings.twitch["username"],
    twitch_token: settings.twitch["token"],
    aws_region: settings.aws["region"],
    aws_access_key_id: settings.aws["access_key_id"],
    aws_secret_access_key: settings.aws["secret_access_key"]
  )
  irc.stream_messages
  irc.run!
rescue Interrupt
  puts "closing..."
  irc.quit
end

require "dotenv/load"
require "zircon"
require_relative "./lib/speaker"

class Irc
  def initialize(twitch_username:, twitch_token:, aws_region:, aws_access_key_id:, aws_secret_access_key:)
    @irc = Zircon.new(
      server: "irc.chat.twitch.tv",
      port: "6667",
      channel: "##{twitch_username}",
      username: twitch_username,
      password: twitch_token
    )
    @speaker = Speaker.new
    @speaker.aws_activate(
      region: aws_region,
      access_key_id: aws_access_key_id,
      secret_access_key: aws_secret_access_key
    )
  end

  def on_message
    @irc.on_message do |message|
      if !message.nil? && !message.from.nil? && !message.body.nil?
        message_body = message.body.force_encoding("UTF-8")
        @speaker.write(from: message.from, message: message_body)
        if !(message.from.include? "tmi.twitch.tv")
          @speaker.vocalize(message_body)
        end
      end
    end
  end

  def run!
    @irc.run!
  end

  def quit
    @irc.quit
  end
end

twitch_username = ENV.fetch("TWITCH_USERNAME")
twitch_token = ENV.fetch("TWITCH_OAUTH_TOKEN")
aws_region = ENV.fetch("AWS_REGION", "ap-northeast-1")
aws_access_key_id = ENV.fetch("AWS_ACCESS_KEY_ID")
aws_secret_access_key = ENV.fetch("AWS_SECRET_ACCESS_KEY")
begin
  puts "starting..."
  irc = Irc.new(
    twitch_username: twitch_username,
    twitch_token: twitch_token,
    aws_region: aws_region,
    aws_access_key_id: aws_access_key_id,
    aws_secret_access_key: aws_secret_access_key
  )
  irc.on_message
  irc.run!
rescue Interrupt
  puts "closing..."
  irc.quit
end

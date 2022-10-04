require "zircon"
require_relative "./speaker"

# Class to Irc for Twitch
class Irc
  # activate Twitch and AWS.
  def activate(twitch_username:, twitch_token:, aws_region:, aws_access_key_id:, aws_secret_access_key:)
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

  # stream messages to TTY.
  def stream_messages
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

  # run irc.
  def run!
    @irc.run!
  end

  # quit irc.
  def quit
    @irc.quit
  end
end

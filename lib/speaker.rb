require "aws-sdk-polly"
require_relative "./mp3players/mpg123"

# Class to speak voice.
class Speaker
  PATH="./vendor/mpg123.exe"

  # activate voice for AWS Polly
  def aws_activate(region:, access_key_id:, secret_access_key:)
    @client = Aws::Polly::Client.new(
      region: region,
      access_key_id: access_key_id,
      secret_access_key: secret_access_key
    )
    @player = Mp3players::Mpg123.new(path: PATH)
  end

  # vocalize message
  def vocalize(message)
    response = @client.synthesize_speech({
      output_format: "mp3",
      text_type: "text",
      voice_id: "Mizuki",
      text: message
    })
    @player.play(stdin_data: response.audio_stream)
  end

  # output console message
  def write(from:, message:)
    puts "#{from} » #{message}"
  end
end
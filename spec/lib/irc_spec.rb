require_relative "../../lib/irc"
require "debug"

# Mock Class
class MockAWSPollyClient
  class Response
    def audio_stream
      `cat ./spec/lib/mp3players/mock/test.mp3`
    end
  end

  def synthesize_speech(*args)
    Response.new
  end
end

RSpec.describe Irc do
  it "#activate is success." do
    irc = Irc.new
    expect(irc.activate(
      twitch_username: "hoge",
      twitch_token: "hoge",
      aws_region: "hoge",
      aws_access_key_id: "hoge",
      aws_secret_access_key: "hoge"
    )).to be_truthy
  end

  it "#stream_messages is success." do
    allow(Aws::Polly::Client).to receive(:new).and_return(MockAWSPollyClient.new)
    allow(Open3).to receive(:capture3).and_return(true)
    speaker = Irc.new
    speaker.activate(
      twitch_username: "hoge",
      twitch_token: "hoge",
      aws_region: "hoge",
      aws_access_key_id: "hoge",
      aws_secret_access_key: "hoge"
    )
    expect(speaker.stream_messages).to be_truthy
  end
end

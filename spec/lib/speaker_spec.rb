require_relative "../../lib/speaker"
require "debug"

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

RSpec.describe Speaker do
  it "#aws_activate is success." do
    speaker = Speaker.new
    expect(speaker.aws_activate(region: "hoge", access_key_id: "hoge", secret_access_key: "hoge")).to be_truthy
  end
  
  it "#vocalize is success." do
    allow(Aws::Polly::Client).to receive(:new).and_return(MockAWSPollyClient.new)
    allow(Open3).to receive(:capture3).and_return(true)
    speaker = Speaker.new
    speaker.aws_activate(region: "hoge", access_key_id: "hoge", secret_access_key: "hoge")
    expect(speaker.vocalize("こんにちは")).to be_truthy
  end
end

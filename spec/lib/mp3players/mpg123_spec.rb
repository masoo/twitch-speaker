require_relative "../../../lib/mp3players/mpg123"
require "debug"

RSpec.describe Mp3players::Mpg123 do
  it "#play is success." do
    player = Mp3players::Mpg123.new(path: "./spec/lib/mp3players/mock/mpg123_mock")
    result = player.play(stdin_data: `cat ./spec/lib/mp3players/mock/test.mp3`)

    expect(result[2]).to be_truthy
  end
end

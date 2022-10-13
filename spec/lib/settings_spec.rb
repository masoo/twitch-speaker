require_relative "../../lib/settings"
require "debug"

RSpec.describe Settings do
  it "#load_json is success." do
    settings = Settings.new
    expect { settings.load_json(path: "./settings.json.example") }.not_to raise_error
  end

  it "aws is success." do
    settings = Settings.new
    settings.load_json(path: "./settings.json.example")
    expect(settings.aws).to be_a_kind_of(Hash)
  end

  it "twitch is success." do
    settings = Settings.new
    settings.load_json(path: "./settings.json.example")
    expect(settings.twitch).to be_a_kind_of(Hash)
  end
end

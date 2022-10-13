require "json"

# Class to settings.
class Settings
  # load json method.
  def load_json(path:)
    @settings = JSON.parse(File.read(path))
  end

  # aws parameters
  def aws
    @settings.dig("aws")
  end

  # twitch parameters
  def twitch
    @settings.dig("twitch")
  end
end

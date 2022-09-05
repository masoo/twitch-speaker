require "open3"

# Class to play using mpg123
module Mp3players
  class Mpg123
    def initialize(path:)
      @command = "#{path} -q -"
    end

    def play(stdin_data:)
      Open3.capture3(@command, stdin_data: stdin_data)
    end
  end
end

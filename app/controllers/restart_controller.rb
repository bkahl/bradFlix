class RestartController < ApplicationController

  def index
    system("osascript -e 'quit app \"iTunes\"'")
    system("open /Applications/iTunes.app/")
  end

end
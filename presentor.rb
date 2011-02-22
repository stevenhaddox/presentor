module Presentor
 class Application < Sinatra::Base
    get '/' do
      @presentations = []
      fakes = %w(. ..)
      Dir.foreach("/usr/bin") do |entry|
         @presentations << entry unless fakes.include? entry
      end
      erb :index
    end
 end
end

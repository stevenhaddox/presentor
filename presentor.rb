module Presentor
 class Application < Sinatra::Base
    get '/' do
      @presentations = []
      fakes = %w(. ..)
      Dir.foreach("public") do |presentation_dir|
         @presentations << presentation_dir unless fakes.include? presentation_dir 
      end
      erb :index
    end
 end
end

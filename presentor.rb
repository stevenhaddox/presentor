module Presentor
 class Application < Sinatra::Base
    get '/' do
      @presentations = []
      fakes = %w(. ..)
      Dir.foreach("public/presentations") do |presentation_dir|
         @presentations << presentation_dir unless fakes.include? presentation_dir
      end
      puts @presentations
      erb :index
    end
 end
end

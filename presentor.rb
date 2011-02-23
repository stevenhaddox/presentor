module Presentor
 class Application < Sinatra::Base

  get '/' do
    @presentations = []
    presentations = YAML::load_file('config/presentations.yml')
    presentations.each do |presentation|
      @presentations << presentation
    end
    erb :index
  end

 end
end

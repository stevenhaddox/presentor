require 'yaml'

namespace :presentor do
  desc "Create the Sinatra project."
  task :init do
    presentations = YAML::load_file('config/presentations.yml')
    presentations.each do |presentation|
      exec("git submodule add #{presentation[:url]} presentations/#{presentation[:title]}")
      exec("git submodule init")
    end
  end
end

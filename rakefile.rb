require 'yaml'

namespace :presentations do
  desc "Clone the presentations from their git repositories into the application."
  task :update do
    system("mkdir -p presentations")
    system("rm -rf presentations/*")
    presentations = YAML::load_file('config/presentations.yml')
    presentations.each do |presentation|
      system("git clone #{presentation[:url]} presentations/#{presentation[:title].gsub(' ','-')}")
    end
  end
  
  desc "Create static versions of the presentations under the public directory."
  task :publish do
    app_root = Dir.pwd
    system("mkdir -p public")
    system("rm -rf public/*")
    presentations = YAML::load_file('config/presentations.yml')
    presentations.each do |presentation|
      system("cd #{app_root}/presentations/#{presentation[:title].gsub(' ','-')}")
      system("bundle exec showoff static")
      system("mv static #{app_root}/public/#{presentation[:title]}")
    end
  end
end

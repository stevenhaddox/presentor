require 'yaml'

namespace :presentations do
  desc "Clone the presentations from their git repositories into the application."
  task :clone do
    system("mkdir -p presentations")
    system("rm -rf presentations/*")
    presentations = YAML::load_file('config/presentations.yml')
    presentations.each do |presentation|
      system("git clone #{presentation[:url]} presentations/#{presentation[:folder]}")
    end
  end
  
  desc "Create static versions of the presentations & symlink in the public directory."
  task :publish do
    app_root = Dir.pwd
    system("mkdir -p public/p")
    system("rm -rf public/p/*")
    presentations = YAML::load_file('config/presentations.yml')
    presentations.each do |presentation|
      system("cd #{app_root}/presentations/#{presentation[:folder]};bundle exec showoff static")
      system("")
      system("ln -s #{app_root}/presentations/#{presentation[:folder]}/static #{app_root}/public/p/#{presentation[:folder]}")
    end
  end
  
  desc "update is just an alias to re-clone & publish the presentations"
  task :update do
    system("bundle exec rake boot:strap")
  end
end

namespace :boot do
  desc "Initialize presentations & publish"
  task :strap do
    puts "\nCloning presentations in #{Dir.pwd}/presentations ..."
    system("bundle exec rake presentations:clone")
    puts "\nCreating static HTML presentations and symlinking to #{Dir.pwd}/public/p ..."
    system("bundle exec rake presentations:publish")
  end
end

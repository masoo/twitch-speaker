desc "running twitch-speaker"
task :run do
  sh "bundle exec ruby main.rb"
end

desc "gem install"
task :geminstall do
  sh "bundle install"
end

desc "exec rspec"
task :test do
  sh "bundle exec rspec"
  sh "bundle exec standardrb --format progress"
end

desc "fix by standardrb"
task :format do
  sh "bundle exec standardrb --format progress --fix"
end

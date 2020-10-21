namespace :test do
    desc "Run tests"
    task :run => ["env:up"] do
        sh "docker-compose exec test bundle install"
        sh "docker-compose exec test bundle exec rspec"
    end
end
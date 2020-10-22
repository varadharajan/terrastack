namespace :test do
    desc "Run tests"
    task :run => ["env:up", "terraform:spec:apply"] do
        modules = MODULES.map { |m| "#{m}spec"}.join(" ")
        sh "docker-compose exec test bundle install"
        sh "docker-compose exec test bash -c 'ENVIRONMENT_FILE=#{CODEBASE}/providers/#{ENVIRONMENT}.rb bundle exec rspec #{modules}'"
    end
end
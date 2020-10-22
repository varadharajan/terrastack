namespace :env do
    desc "Spin up local environment"
    task :up do
        sh "docker-compose up -d"
        sh "docker-compose exec dockerize dockerize -wait tcp://localstack:4566 -timeout 60s"
        puts "Local environment up and running.."
    end

    desc "Terminate local environment"
    task :down do
        `docker-compose down`
        puts "Terminated local environment. Bye!"
    end

    desc "Restart local environment"
    task :restart => ["env:down", "env:up"] do
    end

    desc "Show logs from all containers"
    task :logs => ["env:up"] do
        sh "docker-compose logs -f"
    end
end
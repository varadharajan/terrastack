namespace :env do
    desc "Spin up local environment"
    task :up do
        `docker-compose up -d`
        `docker-compose exec dockerize dockerize -wait tcp://localstack:4566 -timeout 60s`
        p "Local environment up and running.."
    end

    desc "Terminate local environment"
    task :down do
        `docker-compose down`
        p "Terminated local environment. Bye!"
    end
end
namespace :ssh do
	desc "Open a shell to Terraform container"
	task :terraform => ["env:up"] do
		sh "docker-compose exec terraform sh"
	end

	desc "Open a shell to test code (ruby) container"
	task :test => ["env:up"] do
		sh "docker-compose exec test bash"
	end
end
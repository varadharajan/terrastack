namespace :terraform do
    namespace :spec do
        desc "Generate Terraform plan"
        task :plan => ["env:up"] do
            MODULES.each do |m|
                run_terraform_cmd(m, "plan")
            end
        end

        desc "Apply Terraform plan"
        task :apply => ["env:up"] do
            MODULES.each do |m|
                run_terraform_cmd(m, "apply -auto-approve")
                run_terraform_cmd(m, "output -json > output.json")
            end
        end

        desc "Destroy Terraform resources"
        task :destroy => ["env:up"] do
            MODULES.each do |m|
                run_terraform_cmd(m, "destroy -auto-approve")
            end
            ensure
                teardown
        end

        
        def run_terraform_cmd(module_, terraform_cmd)
            setup_module(module_)
            sh "docker-compose exec terraform sh -c 'cd #{module_wd(module_)}; terraform init'"
            sh "docker-compose exec terraform sh -c 'cd #{module_wd(module_)}; terraform #{terraform_cmd}'"
        end

        def setup_module(module_)
            puts "Setting up #{module_}"
            sh "docker-compose exec terraform cp providers/#{ENVIRONMENT}.tf #{module_wd(module_)}/provider.tf"
        end

        def teardown()
            sh "docker-compose exec terraform find modules -type f -name provider.tf -delete"
            sh "docker-compose exec terraform find modules -type f -name output.json -delete"
            sh "docker-compose exec terraform find modules -type f -name terraform.tfstate* -delete"
            sh "docker-compose exec terraform find modules -type d -name .terraform -exec rm -rf {} +"
        end

        def module_wd(module_)
            "#{module_}spec/"
        end
    end
end
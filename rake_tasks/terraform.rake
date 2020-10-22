require 'fileutils'

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
        end

        
        def run_terraform_cmd(module_, terraform_cmd)
            setup_module(module_)
            sh "docker-compose exec terraform sh -c 'cd #{module_wd(module_)}; terraform init'"
            sh "docker-compose exec terraform sh -c 'cd #{module_wd(module_)}; terraform #{terraform_cmd}'"
        end

        def setup_module(module_)
            puts "Setting up #{module_}"

            module_workspace_path = module_wd(module_)
            sh "docker-compose exec terraform cp providers/#{ENVIRONMENT}.tf #{module_workspace_path}/provider.tf"
        end

        

        def module_wd(module_)
            "#{module_}#{module_.start_with?("modules/") ? "spec" : ""}"
        end
    end
end
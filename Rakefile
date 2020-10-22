# All rake tasks are defined in $PROJECT_DIR/rake_tasks
CODEBASE="/data/codebase"
def provided_modules
    (ENV["MODULES"] ? ENV["MODULES"].split(",") : []).map {|x| "#{x.gsub(/\s+/, "")}/"}
end
MODULES = provided_modules.empty? ? Dir["modules/*/"] + Dir["systems/*/"] : provided_modules
ENVIRONMENT=ENV["ENVIRONMENT"] || "local"
puts "Setting environment to #{ENVIRONMENT}"
Rake.add_rakelib 'rake_tasks'
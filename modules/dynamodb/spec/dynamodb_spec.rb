require "#{ENV['ENVIRONMENT_FILE']}"

describe "DynamoDB" do
    it "should create a test DynamoDB table" do
        tables = dynamo().tables.map {|x| x.name}
        expect(tables).to include("test") 
    end
end
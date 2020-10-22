require "#{ENV['ENVIRONMENT_FILE']}"
require 'json'

describe "Tweets" do
    before do
        tf_output_path =  File.join(File.dirname(File.dirname(File.absolute_path(__FILE__))),'output.json')
        @tf_output = JSON.parse(File.read(tf_output_path))
    end

    describe "DynamoDB" do
        it "should create a tweets database" do
            tables = dynamo().tables.map {|x| x.name}
            expect(tables).to include(@tf_output["tweets_db_name"]["value"]) 
        end
    end

    

    describe "E2E tests" do 
        it "should store and retrieve tweets" do
            response = aws_lambda.invoke({function_name: "post_tweets", payload: JSON.dump({"id" => "1", "tweet" => "Hello World!"})})
            expect(response.payload.string).to eq("Ok!")
            response = aws_lambda.invoke({function_name: "post_tweets", payload: JSON.dump({"id" => "2", "tweet" => "Bye World!"})})
            expect(response.payload.string).to eq("Ok!")
            response = aws_lambda.invoke({function_name: "get_tweets"})
            expect(JSON.parse(response.payload.string)).to eq([{"id" => "1", "tweet" => "Hello World!"},{"id" => "2", "tweet" => "Bye World!"}])
        end
    end
end
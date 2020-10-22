require "#{ENV['ENVIRONMENT_FILE']}"

describe "Lambda" do
    it "should invoke the test lambda" do
        resp = aws_lambda.invoke({function_name: "test"})
        expect(resp.payload.string).to include("Hello Varadha") 
    end
end
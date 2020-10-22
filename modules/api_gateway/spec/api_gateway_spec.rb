require "#{ENV['ENVIRONMENT_FILE']}"
require 'json'

describe "APIGateway" do
    before do
        tf_output_path =  File.join(File.dirname(File.absolute_path(__FILE__)),'output.json')
        @tf_output = JSON.parse(File.read(tf_output_path))
    end

    it "should create a test APIGateway" do
        gw_ = api_gateway.get_rest_api({rest_api_id: @tf_output["id"]["value"]})
        expect(gw_.name).to eq("test_api_gw")
    end
end
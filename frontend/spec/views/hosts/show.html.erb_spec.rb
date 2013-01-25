require 'spec_helper'

describe "hosts/show" do
  before(:each) do
    @host = assign(:host, stub_model(Host,
      :service_uri => "Service Uri",
      :auth_token => "Auth Token",
      :profile_ref => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Service Uri/)
    rendered.should match(/Auth Token/)
    rendered.should match(//)
  end
end

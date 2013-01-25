require 'spec_helper'

describe "hosts/index" do
  before(:each) do
    assign(:hosts, [
      stub_model(Host,
        :service_uri => "Service Uri",
        :auth_token => "Auth Token",
        :profile_ref => ""
      ),
      stub_model(Host,
        :service_uri => "Service Uri",
        :auth_token => "Auth Token",
        :profile_ref => ""
      )
    ])
  end

  it "renders a list of hosts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Service Uri".to_s, :count => 2
    assert_select "tr>td", :text => "Auth Token".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end

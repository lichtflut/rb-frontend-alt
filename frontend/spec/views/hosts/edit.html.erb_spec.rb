require 'spec_helper'

describe "hosts/edit" do
  before(:each) do
    @host = assign(:host, stub_model(Host,
      :service_uri => "MyString",
      :auth_token => "MyString",
      :profile_ref => ""
    ))
  end

  it "renders the edit host form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hosts_path(@host), :method => "post" do
      assert_select "input#host_service_uri", :name => "host[service_uri]"
      assert_select "input#host_auth_token", :name => "host[auth_token]"
      assert_select "input#host_profile_ref", :name => "host[profile_ref]"
    end
  end
end

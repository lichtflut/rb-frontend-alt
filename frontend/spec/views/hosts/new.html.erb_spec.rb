require 'spec_helper'

describe "hosts/new" do
  before(:each) do
    assign(:host, stub_model(Host,
      :service_uri => "MyString",
      :auth_token => "MyString",
      :profile_ref => ""
    ).as_new_record)
  end

  it "renders new host form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hosts_path, :method => "post" do
      assert_select "input#host_service_uri", :name => "host[service_uri]"
      assert_select "input#host_auth_token", :name => "host[auth_token]"
      assert_select "input#host_profile_ref", :name => "host[profile_ref]"
    end
  end
end

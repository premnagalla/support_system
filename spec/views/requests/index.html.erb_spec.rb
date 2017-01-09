require 'spec_helper'

describe "requests/index" do
  before(:each) do
    assign(:requests, [
      stub_model(Request,
        :title => "Title",
        :description => "MyText",
        :status => "Status",
        :unique_id => "Unique",
        :department_id => 1,
        :requested_by => 2,
        :updated_by => 3
      ),
      stub_model(Request,
        :title => "Title",
        :description => "MyText",
        :status => "Status",
        :unique_id => "Unique",
        :department_id => 1,
        :requested_by => 2,
        :updated_by => 3
      )
    ])
  end

  it "renders a list of requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Unique".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end

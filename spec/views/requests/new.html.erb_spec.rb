require 'spec_helper'

describe "requests/new" do
  before(:each) do
    assign(:request, stub_model(Request,
      :title => "MyString",
      :description => "MyText",
      :status => "MyString",
      :unique_id => "MyString",
      :department_id => 1,
      :requested_by => 1,
      :updated_by => 1
    ).as_new_record)
  end

  it "renders new request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", requests_path, "post" do
      assert_select "input#request_title[name=?]", "request[title]"
      assert_select "textarea#request_description[name=?]", "request[description]"
      assert_select "input#request_status[name=?]", "request[status]"
      assert_select "input#request_unique_id[name=?]", "request[unique_id]"
      assert_select "input#request_department_id[name=?]", "request[department_id]"
      assert_select "input#request_requested_by[name=?]", "request[requested_by]"
      assert_select "input#request_updated_by[name=?]", "request[updated_by]"
    end
  end
end

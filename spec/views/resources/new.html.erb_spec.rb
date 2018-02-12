require 'rails_helper'

RSpec.describe "resources/new", type: :view do
  before(:each) do
    assign(:resource, Resource.new(
      :name => "MyText",
      :url => "MyString",
      :resource_type => 1
    ))
  end

  it "renders new resource form" do
    render

    assert_select "form[action=?][method=?]", resources_path, "post" do

      assert_select "textarea[name=?]", "resource[name]"

      assert_select "input[name=?]", "resource[url]"

      assert_select "input[name=?]", "resource[resource_type]"
    end
  end
end

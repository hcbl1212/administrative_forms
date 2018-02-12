require 'rails_helper'

RSpec.describe "resources/edit", type: :view do
  before(:each) do
    @resource = assign(:resource, Resource.create!(
      :name => "MyText",
      :url => "MyString",
      :resource_type => 1
    ))
  end

  it "renders the edit resource form" do
    render

    assert_select "form[action=?][method=?]", resource_path(@resource), "post" do

      assert_select "textarea[name=?]", "resource[name]"

      assert_select "input[name=?]", "resource[url]"

      assert_select "input[name=?]", "resource[resource_type]"
    end
  end
end

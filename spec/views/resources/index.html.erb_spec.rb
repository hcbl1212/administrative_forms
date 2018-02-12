require 'rails_helper'

RSpec.describe "resources/index", type: :view do
  before(:each) do
    assign(:resources, [
      Resource.create!(
        :name => "MyText",
        :url => "Url",
        :resource_type => 2
      ),
      Resource.create!(
        :name => "MyText",
        :url => "Url",
        :resource_type => 2
      )
    ])
  end

  it "renders a list of resources" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end

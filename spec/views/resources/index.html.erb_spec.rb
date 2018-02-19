require 'rails_helper'

RSpec.describe "resources/index", type: :view do
  before(:each) do
    assign(:resources, [
      Resource.create!(
        :name => "MyText",
        :url => "Url",
        :resource_type => 1
      ),
      Resource.create!(
        :name => "MyText",
        :url => "Url",
        :resource_type => 1
      )
    ])
  end

  it "renders a list of resources" do
    render
  end
end

require 'rails_helper'

RSpec.describe "resources/show", type: :view do
  before(:each) do
    @resource = assign(:resource, Resource.create!(
      :name => "MyText",
      :url => "Url",
      :resource_type => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/2/)
  end
end

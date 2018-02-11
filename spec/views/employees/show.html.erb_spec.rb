require 'rails_helper'

RSpec.describe "employees/show", type: :view do
  before(:each) do
    @employee = assign(:employee, Employee.create!(
      :employee => false,
      :first_name => "First Name",
      :last_name => "Last Name",
      :middle_initial => "Middle Initial",
      :job_title => "Job Title",
      :email => "12test@email.com",
      :password => "testtest1212"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Middle Initial/)
    expect(rendered).to match(/Job Title/)
    expect(rendered).to match(/12test@email.com/)
  end
end

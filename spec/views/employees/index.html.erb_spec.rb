require 'rails_helper'

RSpec.describe "employees/index", type: :view do
  before(:each) do
    assign(:employees, [
      Employee.create!(
        :employee => false,
        :first_name => "First Name",
        :last_name => "Last Name",
        :middle_initial => "Middle Initial",
        :job_title => "Job Title",
        :email => "test@email.com",
        :password => "testtest1212"

      ),
      Employee.create!(
        :employee => false,
        :first_name => "First Name",
        :last_name => "Last Name",
        :middle_initial => "Middle Initial",
        :job_title => "Job Title",
        :email => "12test@email.com",
        :password => "testtest1212"
      )
    ])
  end

  it "renders a list of employees" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Middle Initial".to_s, :count => 2
    assert_select "tr>td", :text => "test@email.com".to_s, :count => 1
    assert_select "tr>td", :text => "12test@email.com".to_s, :count => 1
  end
end

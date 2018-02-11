require 'rails_helper'

RSpec.describe "employees/edit", type: :view do
  before(:each) do
    @employee = assign(:employee, Employee.create!(
      :employee => false,
      :first_name => "MyString",
      :last_name => "MyString",
      :middle_initial => "MyString",
      :job_title => "MyString",
      :email => "test@email.com",
      :password => "testtest1212"
    ))
  end

  it "renders the edit employee form" do
    render

    assert_select "form[action=?][method=?]", employee_path(@employee), "post" do

      assert_select "input[name=?]", "employee[employee]"

      assert_select "input[name=?]", "employee[first_name]"

      assert_select "input[name=?]", "employee[last_name]"

      assert_select "input[name=?]", "employee[middle_initial]"

      assert_select "input[name=?]", "employee[job_title]"

      assert_select "input[name=?]", "employee[email]"
    end
  end
end

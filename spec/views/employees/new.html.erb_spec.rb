require 'rails_helper'

RSpec.describe "employees/new", type: :view do
  before(:each) do
    assign(:employee, Employee.new(
      :employee => false,
      :first_name => "MyString",
      :last_name => "MyString",
      :middle_initial => "MyString",
      :job_title => "MyString",
      :employee_email => "MyString"
    ))
  end

  it "renders new employee form" do
    render

    assert_select "form[action=?][method=?]", employees_path, "post" do

      assert_select "input[name=?]", "employee[employee]"

      assert_select "input[name=?]", "employee[first_name]"

      assert_select "input[name=?]", "employee[last_name]"

      assert_select "input[name=?]", "employee[middle_initial]"

      assert_select "input[name=?]", "employee[job_title]"

      assert_select "input[name=?]", "employee[employee_email]"
    end
  end
end

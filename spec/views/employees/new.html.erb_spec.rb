require 'rails_helper'

RSpec.describe "employees/new", type: :view do
  before(:each) do
    @employee = Employee.new
    @system_access_request = @employee.system_access_requests.build
    3.times { @system_access_request.signatures.build }
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
      assert_select "select[name=?]", "employee[system_access_requests_attributes][0][effective_date(1i)]"
      assert_select "select[name=?]", "employee[system_access_requests_attributes][0][effective_date(2i)]"
      assert_select "select[name=?]", "employee[system_access_requests_attributes][0][effective_date(3i)]"
      assert_select "input[name=?]", "employee[system_access_requests_attributes][0][department_ids][]"
      assert_select "input[name=?]", "employee[system_access_requests_attributes][0][reason]"
      assert_select "input[id=?]", "employee_system_access_requests_attributes_0_reason_new"
      assert_select "input[id=?]","employee_system_access_requests_attributes_0_reason_change"
      assert_select "input[id=?]","employee_system_access_requests_attributes_0_reason_termination"
      assert_select "input[name=?]", "employee[system_access_requests_attributes][0][system_access_field_ids][]"
      assert_select "input[name=?]", "employee[system_access_requests_attributes][0][group_ids][]"
      assert_select "input[name=?]", "employee[system_access_requests_attributes][0][business_justification]"
      assert_select "input[name=?]", "employee[system_access_requests_attributes][0][privileged_access]"
      assert_select "input[name=?]", "employee[system_access_requests_attributes][0][other_access]"
      assert_select "input[name=?]", "employee[system_access_requests_attributes][0][special_instructions]"
    end
  end
end

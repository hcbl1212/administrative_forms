require 'rails_helper'
require 'test_helper'

RSpec.feature "Employees", type: :feature do
    before :each do
        create_system_access_request_resources
        sign_in_default_employee
    end

    scenario "Create a new Employee and System Access Request", js: true do
        visit "/employees/new"
        expect(Employee.count).to equal(1)
        first('label', text: "Employee").trigger('click')
        fill_in "First name", with: "New"
        fill_in "Middle initial", with: "Sales"
        fill_in "Last name", with: "Representative"
        fill_in "Job title", with: "Saler of stuff"
        fill_in "employee[email]", with: "sales@representative.com"
        select("2014", from: "employee[system_access_requests_attributes][0][effective_date(1i)]", visible: false)
        select("January", from: "employee[system_access_requests_attributes][0][effective_date(2i)]", visible: false)
        select("28", from: "employee[system_access_requests_attributes][0][effective_date(3i)]", visible: false)
        find('label', text: "Accessioning Dep").trigger('click')
        find('label', text: "Information Technology Dep").trigger('click')
        find('label', text: "Vendor Dep").trigger('click')
        first('label', text: "This is a new user", visible: false).trigger('click')

        s1 = Software.first.id
        r1 = Role.find_by_name("Billing Manager Role").id
        first("#employee_system_access_requests_attributes_0_softwares_#{s1}_id", visible: false).trigger('click')
        find("#employee_system_access_requests_attributes_0_softwares_#{s1}_roles_role_ids_#{r1}", visible: false).trigger('click')

        s2 = Software.second.id
        r2 = Role.find_by_name("Claims Role").id
        first("#employee_system_access_requests_attributes_0_softwares_#{s2}_id", visible: false).trigger('click')
        find("#employee_system_access_requests_attributes_0_softwares_#{s2}_roles_role_ids_#{r2}", visible: false).trigger('click')

        s3 = Software.third.id
        r3 = Role.find_by_name("Lab General Role").id
        first("#employee_system_access_requests_attributes_0_softwares_#{s3}_id", visible: false).trigger('click')
        find("#employee_system_access_requests_attributes_0_softwares_#{s3}_roles_role_ids_#{r3}", visible: false).trigger('click')

        find('label', text: "IT Group").trigger('click')
        find('label', text: "Manager Group").trigger('click')
        find('label', text: "Supplies Group").trigger('click')
        find('label', text: "Customer Support Group").trigger('click')

        fill_in "Privileged access", with: "I like extra access"
        fill_in "Business justification", with: "I said please"
        fill_in "Other access", with: "I like other access"
        fill_in "Special instructions", with: "I like to have special instructions"
        click_button('Request Access')
        sleep(3)
        expect(Employee.count).to equal(2)
        employee = Employee.last
        expect(employee.employee).to equal(true)
        expect(employee.first_name).to eq("New")
        expect(employee.middle_initial).to eq("Sales")
        expect(employee.last_name).to eq("Representative")
        expect(employee.job_title).to eq("Saler of stuff")
        expect(employee.email).to eq("sales@representative.com")
        system_access_request = employee.system_access_requests.last
        expect(system_access_request.effective_date.strftime("%Y-%m-%d")).to eq("2014-01-28")
        expect(system_access_request.reason).to eq("new")
        expect(system_access_request.privileged_access).to eq("I like extra access")
        expect(system_access_request.business_justification).to eq("I said please")
        expect(system_access_request.other_access).to eq("I like other access")
        expect(system_access_request.special_instructions).to eq("I like to have special instructions")
        accepted_departments = ["Accessioning Dep","Information Technology Dep","Vendor Dep" ]
        expect(system_access_request.departments.count).to equal(3)
        ord_dep = system_access_request.departments.order("name")
        ord_dep.each_with_index do | dep, index |
            expect(accepted_departments[index]).to eq(dep.name)
        end
        accepted_softwares_and_role = {"Billing (Telcor) Software": "Billing Manager Role",
                                       "LIS (LabHealth) Software": "Lab General Role",
                                       "Clearinghouse (Zirmed) Software": "Claims Role"}
        chosen_softwares = system_access_request.softwares
        # Cool thing about this is we will get an error if all of the softwares we expect to belong to this access request are not there
        chosen_softwares.each do | chosen_soft |
            expect(accepted_softwares_and_role[chosen_soft.name.to_sym]).to eq(system_access_request.software_role(chosen_soft.id).name)
        end

        network_group = ['IT Group', 'Manager Group']
        net_group = system_access_request.groups.where(group_type: "network_security_share").order("name")
        net_group.each_with_index do | net, index |
            expect(network_group[index]).to eq(net.name)
        end
        email_group = ['Customer Support Group', 'Supplies Group']
        em_group = system_access_request.groups.where(group_type: "email").order("name")

        em_group.each_with_index do | email, index |
            expect(email_group[index]).to eq(email.name)
        end
    end
end

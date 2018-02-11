def sign_in_default_employee
    create_default_employee
    visit employee_session_path
    fill_in "Email", with: "batman@wayneenterprises.com"
    fill_in "Password", with: "batman1212"
    click_button 'Log In'
    sleep(2)
end

def create_default_employee
    FactoryBot.create(:employee, first_name: "Bruce", last_name: "Wayne", email: "batman@wayneenterprises.com",
                          job_title: "philanthropist crime fighter", password: 'batman1212'
    )
end

def create_system_access_request_resources
    ['IT Admin Role', 'Admin Role', 'Accessioning Role', 'Accessioning Mngt Role', 'Billing Role', 'Billing Mngt Role',
     'Lab General Role', 'Lab Report/Mngt Role', 'Shipping Role', 'Billing Manager Role', 'Financials Role', 'Payer AR Role',
     'Team Lead Role', 'Claims Role', 'Eligibility Role', 'Remits Role'].each do | role |
        FactoryBot.create(:role, name: role)
    end
    ['Billing (Telcor) Software', 'Clearinghouse (Zirmed) Software', 'LIS (LabHealth) Software'].each do | software |
        new_software = FactoryBot.create(:software, name: software)
        if software =~ /^Billing/
            ['Admin Role', 'Billing Manager Role', 'Financials Role', 'Payer AR Role', 'Team Lead Role'].each do | role |
                new_role = Role.find_by_name(role)
                FactoryBot.create(:software_role, {software_id: new_software.id, role_id: new_role.id})
            end
        elsif software  =~ /^Clearinghouse/
            ['Admin Role', 'Claims Role', 'Eligibility Role', 'Remits Role'].each do | role |
                new_role = Role.find_by_name(role)
                FactoryBot.create(:software_role, {software_id: new_software.id, role_id: new_role.id})
            end
        else
            ['IT Admin Role', 'Admin Role', 'Accessioning Role', 'Accessioning Mngt Role', 'Billing Role',
             'Billing Mngt Role','Lab General Role', 'Lab Report/Mngt Role', 'Shipping Role'].each do | role |
                new_role = Role.find_by_name(role)
                FactoryBot.create(:software_role, {software_id: new_software.id, role_id: new_role.id})
            end
        end
    end

    ['Lab Group', 'Manager Group', 'Accessioning Group', 'IT Group'].each do | group |
        FactoryBot.create(:group_network_security_type, name: group)
    end

    ['Supplies Group', 'Customer Support Group', 'IT-Reno Group', 'Sales Rep Group', 'Everyone Group', 'Lab Group', 'Reporting Group'].
        each do | group |
            FactoryBot.create(:group_email_type, name: group)
    end

    ['Accessioning Dep', 'Administration Dep', 'Billing (Business Office) Dep', 'Human Resources Dep', 'Information Technology Dep',
     'Lab–PGx Dep', 'Lab–Tox Dep', 'Shipping Dep', 'Vendor Dep', '1099 Employee Dep', 'Other Dep'].each do | depart_name |
        FactoryBot.create(:department, name: depart_name)
    end

    ['Email (@MDlabs.com and / or @Rxight.com) SAS', 'Payroll (Paylocity) SAS', 'HIPAA Training (HealthStream) SAS',
     'Security Training (NAScyberNET) SAS', 'Door Access (IntelliM) SAS', 'Instant Messaging (Slack) SAS',
     'Client Portal SAS', 'Active Directory SAS', 'Ultimate Guide SAS', 'Rxight Portal Admin SAS', 'Secret Server (Thycotic) SAS',
     'Sales Rep Portal (Email required): SAS', 'VPN SAS'].each do | system_access_field |
        FactoryBot.create(:system_access_field, name: system_access_field)
     end
end

def employee_hash
   { "employee"=>"true", "first_name"=>"John", "middle_initial"=>"Flipping",
     "last_name"=>"Wayne", "job_title"=>"Cowboy", "email"=>"cowboy@westerns.com" }
end

def system_access_requests_hash
    { "effective_date(1i)"=>"2018", "effective_date(2i)"=>"2", "effective_date(3i)"=>"11",
      "reason"=>"new", "privileged_access"=>"24/7 hourly access",
      "business_justification"=>"I own the place",
      "other_access"=>"roof top", "special_instructions"=>"I like to hike" }
end

def system_access_requests_hash_1
    { "effective_date(1i)"=>"2018", "effective_date(2i)"=>"3", "effective_date(3i)"=>"11",
      "reason"=>"termination", "privileged_access"=>"fun",
      "business_justification"=>"apples",
      "other_access"=>"bat cave", "special_instructions"=>"I like to sleep" }
end

def system_access_requests_hash_2
    { "effective_date(1i)"=>"2018", "effective_date(2i)"=>"3", "effective_date(3i)"=>"12",
      "reason"=>"change", "privileged_access"=>"all the computers",
      "business_justification"=>"worms",
      "other_access"=>"arm pits", "special_instructions"=>"I like to jump" }
end

def create_supervisor_signature!(system_access_request, submitter)
    Signature.create!(
        signature_type: 'supervisor_manager',
        system_access_request_id: system_access_request.id,
        signature: submitter.full_name,
        submitter_id: submitter.id,
        date: Date.today
    )
end

def create_pending_and_non_pending_system_access_requests(employee)
    system_access_request = SystemAccessRequest.create_new_system_access!(system_access_requests_hash, employee)
    submitter = Employee.create_new_employee!(employee_hash)
    create_supervisor_signature!(system_access_request, submitter)
    system_access_request_A = SystemAccessRequest.create_new_system_access!(system_access_requests_hash_1, employee)
    system_access_request_A.approved!
    create_supervisor_signature!(system_access_request_A, submitter)
    system_access_request_R = SystemAccessRequest.create_new_system_access!(system_access_requests_hash_2, employee)
    system_access_request_R.rejected!
    create_supervisor_signature!(system_access_request_R, submitter)
    [[system_access_request, system_access_request_A, system_access_request_R], submitter]
end

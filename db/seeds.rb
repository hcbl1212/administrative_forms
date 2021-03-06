# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    [
        'IT Admin', 'Admin', 'Accessioning', 'Accessioning Mngt', 'Billing', 'Billing Mngt',
        'Lab General', 'Lab Report/Mngt', 'Shipping', 'Billing Manager', 'Financials', 'Payer AR',
        'Team Lead', 'Claims', 'Eligibility', 'Remits'
    ].each do | role |
        Role.create!({ name: role})
    end

    [
        'Email (@MDlabs.com and / or @Rxight.com)', 'Payroll (Paylocity)', 'HIPAA Training (HealthStream)',
        'Security Training (NAScyberNET)', 'Door Access (IntelliM)', 'Instant Messaging (Slack)',
        'Client Portal', 'Active Directory', 'Ultimate Guide', 'Rxight Portal Admin', 'Secret Server (Thycotic)',
        'Sales Rep Portal (Email required)', 'VPN'
    ].each do | system_access_field |
        SystemAccessField.create!({ name: system_access_field})
    end

    ['Lab', 'Manager', 'Accessioning', 'IT'].each do | group |
        Group.create!({ name: group, group_type: 'network_security_share' })
    end

    ['Supplies', 'Customer Support', 'IT-Reno', 'Sales Rep', 'Everyone', 'Lab', 'Reporting'].each do | group |
        Group.create!({ name: group, group_type: 'email' })
    end

    [
        'Billing (Telcor)', 'Clearinghouse (Zirmed)', 'LIS (LabHealth)'
    ].each do | software |
        new_software = Software.create!({ name: software})
        if software =~ /^Billing/
            ['Admin', 'Billing Manager', 'Financials', 'Payer AR', 'Team Lead'].each do | role |
                new_role = Role.find_by_name(role)
                SoftwareRole.create!({ software_id: new_software.id, role_id: new_role.id})
            end
        elsif software  =~ /^Clearinghouse/
            ['Admin', 'Claims', 'Eligibility', 'Remits'].each do | role |
                new_role = Role.find_by_name(role)
                SoftwareRole.create!({ software_id: new_software.id, role_id: new_role.id})
            end
        else
            [
                'IT Admin', 'Admin', 'Accessioning', 'Accessioning Mngt', 'Billing', 'Billing Mngt',
                'Lab General', 'Lab Report/Mngt', 'Shipping'
            ].each do | role |
                new_role = Role.find_by_name(role)
                SoftwareRole.create!({ software_id: new_software.id, role_id: new_role.id})
            end
        end
    end

    [
        'Accessioning', 'Administration', 'Billing (Business Office)', 'Human Resources', 'Information Technology',
        'Lab–PGx', 'Lab–Tox', 'Shipping', 'Vendor', '1099 Employee', 'Other'

    ].each do | department |
        Department.create!({ name: department})
    end


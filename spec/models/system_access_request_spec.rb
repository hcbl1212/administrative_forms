require 'rails_helper'
require 'test_helper'

RSpec.describe SystemAccessRequest, type: :model do
    before :each do
        create_system_access_request_resources
        create_default_employee
        @employee = Employee.first
    end

    it "should create a new system access request and associate it with an employee" do
        expect(@employee.system_access_requests.count).to equal(0)
        expect(SystemAccessRequest.count).to equal(0)
        sar = SystemAccessRequest.create_new_system_access!(system_access_requests_hash, @employee)
        expect(SystemAccessRequest.count).to equal(1)
        expect(@employee.system_access_requests.count).to equal(1)
        expect(@employee.system_access_requests.first.id).to equal(sar.id)
        expect(sar.effective_date.to_s).to eq("2018-02-11")
        expect(sar.reason).to eq("new")
        expect(sar.privileged_access).to eq("24/7 hourly access")
        expect(sar.business_justification).to eq("I own the place")
        expect(sar.other_access).to eq("roof top")
        expect(sar.special_instructions).to eq("I like to hike")
        expect(sar.state).to eq("pending")
    end

    it "should create group, department, and system access fields associations" do
        system_access_request = SystemAccessRequest.create_new_system_access!(system_access_requests_hash, @employee)
        ['group', 'system_access_field', 'department'].each do | association |
            association_class = Object.const_get("SystemAccessRequest#{association.titlecase.delete(' ')}")
            expect(system_access_request.send(association.pluralize).count).to equal(0)
            ass_class = Object.const_get(association.titlecase.delete(' '))
            assoc_ids = [ass_class.first.id, ass_class.second.id, ass_class.last.id]
            system_access_request.create_association!(association, association_class, assoc_ids)
            expect(system_access_request.send(association.pluralize).count).to equal(3)
            expect(system_access_request.send(association.pluralize).first.id).to equal(ass_class.first.id)
            expect(system_access_request.send(association.pluralize).second.id).to equal(ass_class.second.id)
            expect(system_access_request.send(association.pluralize).last.id).to equal(ass_class.last.id)
        end
    end

    it "should return 1 pending system access request by state and submitter id" do
        sars, submitter = create_pending_and_non_pending_system_access_requests(@employee)
        sar = sars.first
        pending = SystemAccessRequest.select_all_state_and_submitter_id(SystemAccessRequest.states[:pending], submitter.id)
        expect(pending.count).to equal(1)
        result = pending.first
        expect(result["employee_id"]).to eq(@employee.id)
        expect(result["job_title"]).to eq(@employee.job_title)
        expect(result["effective_date"]).to eq(sar.effective_date)
        expect(result["reason"]).to eq("new")
        expect(SystemAccessRequest.states.key(result["state"])).to eq("pending")

    end

    it "should return 1 approved and 1 rejected system access requests by state and submitter id" do
        sars, submitter = create_pending_and_non_pending_system_access_requests(@employee)
        not_pending = SystemAccessRequest.select_all_state_and_submitter_id(
            [SystemAccessRequest.states[:rejected],
             SystemAccessRequest.states[:approved]], submitter.id)
        expect(not_pending.count).to equal(2)
        approved_sar = sars[1]
        approved_result = not_pending.first
        expect(approved_result["employee_id"]).to eq(@employee.id)
        expect(approved_result["job_title"]).to eq(@employee.job_title)
        expect(approved_result["effective_date"]).to eq(approved_sar.effective_date)
        expect(approved_result["reason"]).to eq("termination")
        expect(SystemAccessRequest.states.key(approved_result["state"])).to eq("approved")
        rejected_sar = sars[2]
        rejected_result = not_pending.last
        expect(rejected_result["employee_id"]).to eq(@employee.id)
        expect(rejected_result["job_title"]).to eq(@employee.job_title)
        expect(rejected_result["effective_date"]).to eq(rejected_sar.effective_date)
        expect(rejected_result["reason"]).to eq("change")
        expect(SystemAccessRequest.states.key(rejected_result["state"])).to eq("rejected")
    end

end

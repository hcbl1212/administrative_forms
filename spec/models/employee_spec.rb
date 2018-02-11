require 'rails_helper'

RSpec.describe Employee, type: :model do
    it "should return only the first and last name if the middle name is blank" do
        employee = FactoryBot.create(:employee, first_name: "Bruce", last_name: "Wayne", email: "batman@wayneenterprises.com",
                          job_title: "philanthropist crime fighter", password: 'batman1212'
                   )
        expect(employee.full_name).to eq("Bruce Wayne")
    end

    it "should return the first, middle, and last name if middle name is not blank" do
        employee = FactoryBot.create(:employee, first_name: "Bruce", middle_initial: "W",  last_name: "Wayne", email: "batman@wayneenterprises.com",
                          job_title: "philanthropist crime fighter", password: 'batman1212'
                   )
        expect(employee.full_name).to eq("Bruce W Wayne")
    end

    it "should create a new employee with the given attributes" do
        employee = Employee.create_new_employee!(employee_hash)
        expect(employee.employee).to equal(true)
        expect(employee.first_name).to eq("John")
        expect(employee.middle_initial).to eq("Flipping")
        expect(employee.last_name).to eq("Wayne")
        expect(employee.job_title).to eq("Cowboy")
        expect(employee.email).to eq("cowboy@westerns.com")
    end
end

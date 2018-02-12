require 'rails_helper'
require 'test_helper'

RSpec.feature "System Access Requests", type: :feature do
    before :each do
        create_system_access_request_resources
        sign_in_default_employee
        sleep(2)
        @employee = Employee.first
        @sars, @submitter = create_inverse_user_pending_and_non_pending_system_access_requests(@employee)
    end

    scenario "View pending system access requests", js: true do
        find('#pending-requests', visible: false).trigger('click')
        sleep(2)
        expect(page).to have_content('Pending Requests')
        expect(page).to have_content('John Wayne')
        expect(page).to have_content('Cowboy')
        expect(page).to have_content('This is a new user.')
        expect(page).to have_content('2018-02-11')
        expect(page).to have_content('Pending')
    end

    scenario "View pending system access requests", js: true do
        find('#not-pending-requests', visible: false).trigger('click')
        sleep(2)
        expect(page).to have_content('Approved/Rejected Requests')
        expect(page).to have_content('John Wayne')
        expect(page).to have_content('Cowboy')
        expect(page).to have_content('This is a termination user.')
        expect(page).to have_content('2018-03-11')
        expect(page).to have_content('Approved')
        expect(page).to have_content('This is a change user.')
        expect(page).to have_content('2018-03-12')
        expect(page).to have_content('Rejected')
    end
end

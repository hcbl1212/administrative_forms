require 'rails_helper'
require 'test_helper'

RSpec.feature "System Access Requests", type: :feature do
    describe 'As a standard user ' do
        before :each do
            create_system_access_request_resources
            sign_in_default_employee
            sleep(2)
            @employee = Employee.first
            @sars, @submitter = create_inverse_user_pending_and_non_pending_system_access_requests(@employee)
        end

        scenario "View pending system access requests", js: true do
            first('#pending-requests', visible: false).trigger('click')
            sleep(2)
            expect(page).to have_content('Pending Requests')
            expect(page).to have_content('John Wayne')
            expect(page).to have_content('Cowboy')
            expect(page).to have_content('This is a new user.')
            expect(page).to have_content('2018-02-11')
            expect(page).to have_content('Pending')
            expect(page).to_not have_selector('a#approve-sar')
            expect(page).to_not have_selector('a#reject-sar')
        end

        scenario "View not pending system access requests", js: true do
            first('#not-pending-requests', visible: false).trigger('click')
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
            expect(page).to_not have_selector('a#approve-sar')
            expect(page).to_not have_selector('a#reject-sar')
        end
    end


    describe 'As an admin user', js: true do
        before :each do
            create_system_access_request_resources
            sign_in_admin_employee
            sleep(2)
            @employee = Employee.first
            @sars, @submitter = create_inverse_user_pending_and_non_pending_system_access_requests(@employee)
        end

        scenario "View pending system access requests", js: true do
            first('#pending-requests', visible: false).trigger('click')
            sleep(2)
            expect(page).to have_content('Pending Requests')
            expect(page).to have_content('John Wayne')
            expect(page).to have_content('Cowboy')
            expect(page).to have_content('This is a new user.')
            expect(page).to have_content('2018-02-11')
            expect(page).to have_content('Pending')
            expect(page).to have_selector('a#approve-sar')
            expect(page).to have_selector('a#reject-sar')
        end

        scenario "View not pending system access requests", js: true do
            first('#not-pending-requests', visible: false).trigger('click')
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

        scenario "Transition pending system access request to approved", js: true do
            pending = SystemAccessRequest.where(state: 'pending')
            approved = SystemAccessRequest.where(state: 'approved')
            pen_sar = pending.first
            expect(pen_sar.pending?).to be(true)
            expect(pending.count).to equal(1)
            expect(approved.count).to equal(1)
            first('#pending-requests', visible: false).trigger('click')
            sleep(2)
            expect(page).to have_content('Pending Requests')
            expect(page).to have_content('John Wayne')
            expect(page).to have_content('Cowboy')
            expect(page).to have_content('This is a new user.')
            expect(page).to have_content('2018-02-11')
            expect(page).to have_content('Pending')
            expect(page).to have_selector('a#approve-sar')
            expect(page).to have_selector('a#reject-sar')
            find("#approve-sar").click
            sleep(4)
            expect(page).to_not have_content('John Wayne')
            expect(page).to_not have_content('Cowboy')
            expect(page).to_not have_content('This is a new user.')
            expect(page).to_not have_content('2018-02-11')
            first('#not-pending-requests', visible: false).trigger('click')
            sleep(2)
            expect(page).to have_content('John Wayne')
            expect(page).to have_content('Cowboy')
            expect(page).to have_content('This is a new user.')
            expect(page).to have_content('2018-02-11')
            expect(SystemAccessRequest.where(state: 'pending').count).to equal(0)
            expect(SystemAccessRequest.where(state: 'approved').count).to equal(2)
            expect(pen_sar.reload.pending?).to equal(false)
            expect(pen_sar.reload.approved?).to equal(true)
        end

        scenario "Transition pending system access request to rejected", js: true do
            pending = SystemAccessRequest.where(state: 'pending')
            rejected = SystemAccessRequest.where(state: 'rejected')
            pen_sar = pending.first
            expect(pen_sar.pending?).to be(true)
            expect(pending.count).to equal(1)
            expect(rejected.count).to equal(1)
            first('#pending-requests', visible: false).trigger('click')
            sleep(2)
            expect(page).to have_content('Pending Requests')
            expect(page).to have_content('John Wayne')
            expect(page).to have_content('Cowboy')
            expect(page).to have_content('This is a new user.')
            expect(page).to have_content('2018-02-11')
            expect(page).to have_content('Pending')
            expect(page).to have_selector('a#approve-sar')
            expect(page).to have_selector('a#reject-sar')
            find("#reject-sar").click
            sleep(4)
            expect(page).to_not have_content('John Wayne')
            expect(page).to_not have_content('Cowboy')
            expect(page).to_not have_content('This is a new user.')
            expect(page).to_not have_content('2018-02-11')
            first('#not-pending-requests', visible: false).trigger('click')
            sleep(2)
            expect(page).to have_content('John Wayne')
            expect(page).to have_content('Cowboy')
            expect(page).to have_content('This is a new user.')
            expect(page).to have_content('2018-02-11')
            expect(SystemAccessRequest.where(state: 'pending').count).to equal(0)
            expect(SystemAccessRequest.where(state: 'rejected').count).to equal(2)
            expect(pen_sar.reload.pending?).to equal(false)
            expect(pen_sar.reload.rejected?).to equal(true)
        end
    end
end

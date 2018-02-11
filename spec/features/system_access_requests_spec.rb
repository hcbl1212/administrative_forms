require 'rails_helper'
require 'test_helper'

RSpec.feature "System Access Requests", type: :feature do
    before :each do
        create_system_access_request_resources
        sign_in_default_employee
    end

    scenario "View pending system access requests", js: true do
    end

    scenario "View pending system access requests", js: true do
    end
end

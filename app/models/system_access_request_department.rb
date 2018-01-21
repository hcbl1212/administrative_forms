class SystemAccessRequestDepartment < ApplicationRecord
    belongs_to :system_access_request
    belongs_to :department
end

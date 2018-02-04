class SystemAccessRequestSoftware < ApplicationRecord
    belongs_to :software, optional: true
    belongs_to :system_access_request, optional: true
    belongs_to :role, optional: true
end

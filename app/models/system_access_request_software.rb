class SystemAccessRequestSoftware < ApplicationRecord
    belongs_to :software
    belongs_to :system_access_request
    belongs_to :role
end

class SystemAccessRequestSystemAccessField < ApplicationRecord
    belongs_to :system_access_requests
    belongs_to :system_access_fields
end

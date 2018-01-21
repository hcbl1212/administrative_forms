class SystemAccessRequestGroup < ApplicationRecord
    belongs_to :group
    belongs_to :system_access_request
end

class Group < ApplicationRecord
    has_many :system_access_request_groups
    has_many :system_access_requests, through: :system_access_request_groups
end

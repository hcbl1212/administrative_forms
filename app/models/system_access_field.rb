class SystemAccessField < ApplicationRecord
    has_many :system_access_request_system_access_fields
    has_many :system_access_requests, through: :system_access_request_system_access_fields
    validates :name, uniqueness: true
end

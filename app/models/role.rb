class Role < ApplicationRecord
    has_one :system_access_request_software
    has_many :software_roles
    validates :name, uniqueness: true
end

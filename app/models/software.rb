class Software < ApplicationRecord
    has_many :system_access_request_softwares
    has_many :system_access_requests, through: :system_access_request_softwares
    has_many :software_roles
    has_many :roles, through: :software_roles
    validates :name, uniqueness: true
end

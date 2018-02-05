class Department < ApplicationRecord
    has_many :system_access_request_departments
    has_many :system_access_requests, through: :system_access_request_departments
    validates :name, uniqueness: true
end

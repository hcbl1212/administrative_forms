class Employee < ApplicationRecord
    has_many :system_access_requests
    accepts_nested_attributes_for :system_access_requests
end

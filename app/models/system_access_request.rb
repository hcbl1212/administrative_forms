class SystemAccessRequest < ApplicationRecord
    belongs_to :employee
    has_many :system_access_request_departments
    has_many :departments, through: :system_access_request_departments
    has_many :system_access_request_groups
    has_many :groups, through: :system_access_request_groups
    has_many :signatures
    has_many :system_access_request_system_access_fields
    has_many :system_access_fields, through: :system_access_request_system_access_fields
    accepts_nested_attributes_for :signatures

    REASONS = ['new', 'change', 'termination'].freeze.map(&:freeze)


end

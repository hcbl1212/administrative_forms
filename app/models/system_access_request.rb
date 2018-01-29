class SystemAccessRequest < ApplicationRecord
    belongs_to :employee
    has_many :system_access_request_departments
    has_many :departments, through: :system_access_request_departments
    has_many :system_access_request_groups
    has_many :groups, through: :system_access_request_groups
    has_many :system_access_request_softwares
    has_many :softwares, through: :system_access_request_softwares
    has_many :system_access_request_system_access_fields
    has_many :system_access_fields, through: :system_access_request_system_access_fields
    has_many :signatures, dependent: :destroy
    accepts_nested_attributes_for :signatures

    REASONS = ['new', 'change', 'termination'].freeze.map(&:freeze)

    def software_role(software_id)
        SystemAccessRequestSoftware.find_by_software_id_and_system_access_request_id(software_id, self.id).role rescue nil
    end

end

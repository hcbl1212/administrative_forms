class SystemAccessRequest < ApplicationRecord
    include ParamMassageUtilities
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

    class << self
        def create_new_system_access!(attributes, employee)
            system_access_request = SystemAccessRequest.new
            system_access_request.reason = attributes[:reason]
            system_access_request.effective_date = system_access_request.format_date(attributes, "effective_date".freeze)
            system_access_request.privileged_access = attributes[:privileged_access]
            system_access_request.business_justification = attributes[:business_justification]
            system_access_request.special_instructions = attributes[:special_instructions]
            system_access_request.other_access = attributes[:other_access]
            system_access_request.sales_rep_email = attributes[:sales_rep_email]
            employee.system_access_requests << system_access_request
            employee.save!
            system_access_request.save!
            system_access_request
        end
    end

    def create_association!(association, association_class, assoc_ids)
            assoc_ids.each do | assoc_id |
            assoc_obj = association_class.new
            assoc_obj.system_access_request_id = self.id
            assoc_obj.send("#{association}_id=".to_sym, assoc_id)
            assoc_obj.save!
            assoc_obj
        end
    end

    def software_role(software_id)
        SystemAccessRequestSoftware.find_by_software_id_and_system_access_request_id(software_id, self.id).role rescue nil
    end
end

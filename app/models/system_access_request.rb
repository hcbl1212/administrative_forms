class SystemAccessRequest < ApplicationRecord
    include ParamMassageUtilities
    belongs_to :employee, optional: true
    has_many :system_access_request_departments
    has_many :departments, through: :system_access_request_departments
    has_many :system_access_request_groups
    has_many :groups, through: :system_access_request_groups
    has_many :system_access_request_softwares
    has_many :softwares, through: :system_access_request_softwares
    has_many :system_access_request_system_access_fields
    has_many :system_access_fields, through: :system_access_request_system_access_fields
    has_many :signatures, dependent: :destroy
    has_one :external_action_authorization
    accepts_nested_attributes_for :signatures

    enum state: [:pending, :rejected, :approved]

    REASONS = ['new', 'change', 'termination'].freeze.map(&:freeze)

    class << self
        def create_new_system_access!(attributes, employee)
            system_access_request = SystemAccessRequest.new
            system_access_request.effective_date = SystemAccessRequest.format_date(attributes, "effective_date".freeze)
            system_access_request.reason = attributes['reason']
            system_access_request.privileged_access = attributes['privileged_access']
            system_access_request.business_justification = attributes['business_justification']
            system_access_request.special_instructions = attributes['special_instructions']
            system_access_request.other_access = attributes['other_access']
            system_access_request.sales_rep_email = attributes['sales_rep_email']
            employee.system_access_requests << system_access_request
            employee.save!(validate: false)
            system_access_request.save!
            system_access_request.pending!
            system_access_request
        end

        def select_all_state_and_submitter_id(state, submitter_id)
            state_and_submitter_query = <<-SQL
                SELECT e.id AS employee_id, CONCAT(e.first_name, ' ', e.last_name) AS full_name, e.job_title,
                       sar.effective_date, sar.reason, sar.state, sar.id AS system_access_request_id
                FROM employees e
                INNER JOIN system_access_requests sar ON sar.employee_id = e.id
                INNER JOIN signatures sig ON sig.system_access_request_id = sar.id
                WHERE
                    sar.state IN (#{[*state].join(',')})
                AND
                    sig.submitter_id = #{submitter_id}
                GROUP BY e.id, sar.id
            SQL
            ActiveRecord::Base.connection.select_all(state_and_submitter_query)
        end

        def check_external_action(action_to_try)
            return nil unless self.allowed_external_actions.include?(action_to_try)
            action_to_try
        end

        def allowed_external_actions
            self.states.keys - ["pending"]
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

    def manager_signatures
        self.signatures.where(signature_type: "supervisor_manager")
    end

    def change_state_and_use_external_action(action_to_perform)
        self.state = action_to_perform
        self.save!
        self.external_action_authorization.used!
    end

    def software_role(software_id)
        SystemAccessRequestSoftware.find_by_software_id_and_system_access_request_id(software_id, self.id).role rescue nil
    end

    def external_action_auth_code
        self.external_action_authorization.authorization_code
    end

    def construct_external_action_url(action)
        "system_access_request_external_action?sar_id=#{self.id}&sar_action=#{action}&authorization_code=#{self.external_action_auth_code}"
    end

    def external_response_json
        {
            employee_name: self.employee.full_name,
            reason: self.reason,
            current_status: self.state

        }.to_json
    end

end

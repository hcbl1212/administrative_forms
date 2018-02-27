class SystemAccessRequestRegistration

    def initialize(system_access_registration, employee)
        @sar = system_access_registration
        @employee = employee
    end

    def run
        return unless @employee.standard?
        is_sales_rep = @sar.system_access_fields.pluck(:name).any? { | name | name.match(/^Sales Rep Portal/)}
        @employee.role = "sales_rep" if is_sales_rep == true
        @employee.save(validate: false)
        self.send_approval_or_rejection_email_to_it
    end


    def set_up_external_authorization_action
        ExternalActionAuthorization.create(system_access_request_id: @sar.id)
    end

    def send_approval_or_rejection_email_to_it
        self.set_up_external_authorization_action
        SystemAccessRequestMailer.employee_system_access_request(@sar).deliver_now
    end

end

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
    end

end

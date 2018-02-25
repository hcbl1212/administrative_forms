class Signature < ApplicationRecord
    belongs_to :system_access_request, optional: true

    enum signature_type: {
        supervisor_manager: 1,
        it_security: 2,
        it_dept_sign_off: 3
    }

    class << self
        def managers_signatures
            self.where(signature_type: "supervisor_manager")
        end
    end

    def submitter
        Employee.find(self.submitter_id)
    end

    def submitter_name
        self.submitter.full_name
    end
end

class Signature < ApplicationRecord
    belongs_to :system_access_request

    enum signature_type: {
        supervisor_manager: 1,
        it_security: 2,
        it_dept_sign_off: 3
    }
end

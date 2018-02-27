class ExternalActionAuthorization < ApplicationRecord
    before_create :create_authorization_code
    after_create :set_state
    enum state: [:unused, :used]

    EXTERNAL_ACTION_AUTHORIZATION_REJECTIONS = {
        no_sar: "System Access Request doesn't exist.".freeze,
        used_auth_code: "External Authorization Code is already used.".freeze,
        no_auth_code_found: "Not permitted to perform this action.".freeze
    }

    class << self
        def detect_invalid_external_action_reason(sar)
            sar.nil? ? :no_sar : :used_auth_code
        end
    end

    private
        def create_authorization_code
            self.authorization_code = SecureRandom.uuid
        end

        def set_state
            self.unused!
        end
end

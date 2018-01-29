FactoryBot.define do
    factory :group do
        name ""

        factory :group_email_type do
            group_type "email"
        end

        factory :group_network_security_type do
            group_type "network_security_share"
        end
    end
end

class SystemAccessRequestMailer < ApplicationMailer
  default from: 'administrative-forms@mdlabs.com'

    def employee_system_access_request(system_access_request)
        @user = system_access_request
        @url  = 'http://example.com/login'
        mail(to: 'it@mdlabs.com', subject: 'A New System Access Request Has Been Submitted')
    end
end

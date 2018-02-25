class SystemAccessRequestMailer < ApplicationMailer
  default from: 'administrative-forms@mdlabs.com'

    def employee_system_access_request(system_access_request)
        @employee = system_access_request.employee
        @sar = system_access_request
        @url  = 'localhost:3000'
        mail(to: 'it@mdlabs.com', subject: 'A New System Access Request Has Been Submitted')
    end

end

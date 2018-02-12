module ControllerMacros
    def login_employee
        before(:each) do
            @request.env["devise.mapping"] = Devise.mappings[:employee]
            sign_in FactoryBot.create(:employee, first_name: "Bruce", last_name: "Wayne", email: "batman@wayneenterprises.com",
                          job_title: "philanthropist crime fighter", password: 'batman1212'
                   )
        end
    end

end

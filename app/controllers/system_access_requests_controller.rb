class SystemAccessRequestsController < ApplicationController
    before_action :set_employee, only: [:pending, :not_pending]

    def pending
pending_query <<-SQL
    Select 
SQL


        Employee
        raise @employee.inspect 
    end

    def not_pending
        raise params.inspect 
    end

    private
        def set_employee
            @employee ||= Employee.includes(:system_access_requests).where(id: params[:employee_id])
        end

end

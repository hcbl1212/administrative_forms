class SystemAccessRequestsController < ApplicationController
    before_action :set_employee, only: [:show, :index]
    before_action :set_query_type, only: [:show, :index]

    # GET /employees
    # GET /employees.json
    def index
        @employees = Employee.all
    end

    # GET /employees/1
    # GET /employees/1.json
    def show
    end



    private
        # Use callbacks to share common setup or constraints between actions.
        def set_employee
            @employee = Employee.includes({
                system_access_requests: [:groups, :departments, :softwares, :system_access_fields] }).find(params[:employee_id])
        end

end

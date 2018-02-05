class EmployeesController < ApplicationController
    include ParamMassageUtilities
    before_action :set_employee, only: [:show, :edit, :update, :destroy]

    # GET /employees
    # GET /employees.json
    def index
        @employees = Employee.all
    end

    # GET /employees/1
    # GET /employees/1.json
    def show
    end

    # GET /employees/new
    def new
        @employee = Employee.new
        @system_access_request = @employee.system_access_requests.build
        3.times { @system_access_request.signatures.build }
    end

    # GET /employees/1/edit
    def edit
    end

    # POST /employees
    # POST /employees.json
    def create
        Employee.transaction do
            #so we are either going to add it to an existing employee or create a new one
            @employee = Employee.find_by_employee_email(employee_params[:employee_email])
            @employee = Employee.create_new_employee!(employee_params) if @employee.nil?
            raise ActiveRecord::Rollback unless SystemAccessRequest.transaction(requires_new: true) do
                system_access_requests_params = employee_params[:system_access_requests_attributes]["0"]
                system_access_request = SystemAccessRequest.create_new_system_access!(system_access_requests_params, @employee)
                ['group', 'system_access_field', 'department'].each do | association |
                    association_class = Object.const_get("SystemAccessRequest#{association.titlecase.delete(' ')}")
                    raise ActiveRecord::Rollback unless association_class.transaction(requires_new: true) do
                        assoc_ids = system_access_requests_params["#{association}_ids"].reject(&:blank?)
                        system_access_request.create_association!(association, association_class, assoc_ids)
                    end
                end
                # populate all of the softwares and their roles
                Software.first.id.upto(Software.last.id).each do | index |
                    software = system_access_requests_params[:softwares][index.to_s]
                    # if they didnt' select a role then they cannot have the software
                    # this is validated on the front end.
                    next if software[:roles][:role_ids].to_s.empty?
                    raise ActiveRecord::Rollback unless SystemAccessRequestSoftware.transaction(requires_new: true) do
                        SystemAccessRequestSoftware.create!({
                            software_id: software[:id],
                            system_access_request_id: system_access_request.id,
                            role_id: software[:roles][:role_ids]
                        })
                    end
                end
            end
        end


        respond_to do |format|
            unless @employee.id.nil?
                format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
                format.json { render :show, status: :created, location: @employee }
            else
                format.html { render :new }
                format.json { render json: @employee.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /employees/1
    # PATCH/PUT /employees/1.json
    def update
        respond_to do |format|
            if @employee.update(employee_params)
                format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
                format.json { render :show, status: :ok, location: @employee }
            else
                format.html { render :edit }
                format.json { render json: @employee.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /employees/1
    # DELETE /employees/1.json
    def destroy
        @employee.destroy
        respond_to do |format|
            format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_employee
            @employee = Employee.includes({
                system_access_requests: [:groups, :departments, :softwares, :system_access_fields] }).find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def employee_params
            params.require(:employee).permit(
                :employee, :first_name, :last_name, :middle_initial, :job_title, :employee_email,
                {
                    system_access_requests_attributes: [
                                        :effective_date, :reason, :privileged_access, :business_justification,
                                        :special_instructions, :other_access, :sales_rep_email,
                                        {system_access_field_ids: []},
                                        {department_ids: []},
                                        {group_ids: []},
                                        softwares: [:id, roles: [:role_ids]],
                                        signatures_attributes: [
                                            :signature_type, :signature, :date
                                        ]
                                    ]
                }
            )
        end
end

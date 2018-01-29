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
            @employee = Employee.new
            @employee.employee = employee_params[:employee]
            @employee.employee_email = employee_params[:employee_email]
            @employee.first_name = employee_params[:first_name]
            @employee.middle_initial = employee_params[:middle_initial]
            @employee.last_name = employee_params[:last_name]
            @employee.job_title = employee_params[:job_title]
            @employee.save!
            raise ActiveRecord::Rollback unless SystemAccessRequest.transaction(requires_new: true) do
                system_access_requests_params = employee_params[:system_access_requests_attributes]["0"]
                system_access_request = SystemAccessRequest.new
                system_access_request.reason =  system_access_requests_params[:reason]
                system_access_request.effective_date =  format_date(system_access_requests_params, "effective_date")
                system_access_request.privileged_access = system_access_requests_params[:privileged_access]
                system_access_request.business_justification = system_access_requests_params[:business_justification]
                system_access_request.special_instructions = system_access_requests_params[:special_instructions]
                system_access_request.other_access = system_access_requests_params[:other_access]
                system_access_request.sales_rep_email = system_access_requests_params[:sales_rep_email]
                @employee.system_access_requests << system_access_request
                system_access_request.save!
                #raise system_access_requests_params.inspect
                ['group', 'system_access_field', 'department'].each do | association |
                    raise ActiveRecord::Rollback unless Object.const_get("SystemAccessRequest#{association.titlecase.delete(' ')}")
                                                                                    .transaction(requires_new: true) do
                        assoc_ids = system_access_requests_params["#{association}_ids"].reject(&:blank?)
                        assoc_ids.each do | assoc_id |
                            assoc_obj = Object.const_get("SystemAccessRequest#{association.titlecase.delete(' ')}").new
                            assoc_obj.system_access_request_id = system_access_request.id
                            assoc_obj.send("#{association}_id=".to_sym, assoc_id)
                            assoc_obj.save!
                        end
                    end
                end

                0.upto(2).each do | index |
                    signature = system_access_requests_params[:signatures_attributes][index.to_s]
                    raise ActiveRecord::Rollback unless Signature.transaction(requires_new: true) do
                        system_access_request.signatures << Signature.create!({
                                                        signature: signature[:signature],
                                                        date: format_date(signature, "date"),
                                                        signature_type: signature[:signature_type]
                        })
                    end
                end
                #populate all of the softwares and their roles
                Software.first.id.upto(Software.last.id).each do | index |
                    software = system_access_requests_params[:softwares][index.to_s]
                    raise ActiveRecord::Rollback unless SystemAccessRequestSoftware.transaction(requires_new: true) do
                        SystemAccessRequestSoftware.create!({
                            software_id: software[:id],
                            system_access_request_id: system_access_request.id,
                            role_id: software[:roles][:role_ids]
                        })
                    end
                end
                @employee.save!
                system_access_request.save!
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
            @employee = Employee.find(params[:id])
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

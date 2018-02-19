class SystemAccessRequestsController < ApplicationController
    def index
        @system_access_requests = SystemAccessRequest.includes(:employee).all
    end

    def update
       sar = SystemAccessRequest.find(system_access_request_params[:id]).send("#{system_access_request_params[:state]}!")
       render json: sar
    end

    def pending
        @pending_sars = SystemAccessRequest.select_all_state_and_submitter_id(SystemAccessRequest.states[:pending], current_employee.id)
    end

    def not_pending
        @not_pending_sars = SystemAccessRequest.select_all_state_and_submitter_id(
            [SystemAccessRequest.states[:rejected], SystemAccessRequest.states[:approved]],
            current_employee.id
        )
    end

    private
        def system_access_request_params
            params.require(:system_access_request).permit(:id, :state)
        end

end

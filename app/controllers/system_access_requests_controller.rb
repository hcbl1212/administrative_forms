class SystemAccessRequestsController < ApplicationController
    skip_before_action :authenticate_employee!, :only => [:external_action]

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

    def external_action
        unless ExternalActionAuthorization.where(authorization_code: params[:authorization_code]).first.nil?
            if (action_to_perform = SystemAccessRequest.check_external_action(params[:sar_action]))
                sar = SystemAccessRequest.where(id: params[:sar_id]).first
                return render json: invalid_response(sar) if invalid_request?(sar)
                sar.change_state_and_use_external_action(action_to_perform)
                return render json: sar.external_response_json
            end
            render json: { failure: "#{params[:sar_action].titlecase} action is not in the allowed action list" }
        end
        render json: { failure: ExternalActionAuthorization::EXTERNAL_ACTION_AUTHORIZATION_REJECTIONS[:no_sar] }
    end

    private
        def invalid_request?(sar)
            sar.nil? || sar.external_action_authorization.used?
        end

        def invalid_response(sar)
            {
                failure:
                ExternalActionAuthorization::EXTERNAL_ACTION_AUTHORIZATION_REJECTIONS[ExternalActionAuthorization.
                    detect_invalid_external_action_reason(sar)]
            }.to_json
        end

        def system_access_request_params
            params.require(:system_access_request).permit(:id, :state)
        end

end

class SystemAccessRequestsController < ApplicationController

    def pending
        @pending_sars = SystemAccessRequest.select_all_state_and_submitter_id(SystemAccessRequest.states[:pending], current_employee.id)
    end

    def not_pending
        @not_pending_sars = SystemAccessRequest.select_all_state_and_submitter_id(
            [SystemAccessRequest.states[:rejected], SystemAccessRequest.states[:approved]],
            current_employee.id
        )
    end


end

$(document).on('turbolinks:load', function() {
     $('.modal').modal();
    new SystemAccessRequestTable("sar-table", "sarId", "approve-sar", "reject-sar");
});

class SystemAccessRequestTable {
    constructor(
        tableID, dataAttribute, approveID, rejectID, defaultNoDataMessage = "No system access requests with this status currently exist."
    ) {
        this.tableID = tableID;
        this.defaultNoDataMessage = defaultNoDataMessage;
        this._initialize();
        this.sysAccStatUp = new SystemAccessStatusUpdate(dataAttribute, approveID, rejectID)
    }

    _initialize() {
        this._initDataTable();
    }

    _initDataTable() {
        const _this = this;
        $(`#${_this.tableID}`).dataTable({
            "bPaginate": false,
            "bLengthChange": false,
            "bFilter": true,
            "bInfo": false,
            "language": {
                "emptyTable": _this.defaultNoDataMessage
            }
        });
    }

}

class SystemAccessStatusUpdate {
    constructor(dataAttribute, approveID, rejectID) {
        this.sarDataAttr = dataAttribute;
        this.approveID = approveID;
        this.rejectID = rejectID;
        this._initialize();
    }

    _initialize() {
        const {rejectID, approveID} = this;
        this.actions = {
            [rejectID]: "rejected",
            [approveID]: "approved"
        };
        this.BASE_URL = "/system_access_requests/";
        this.PRIMARY_METHOD = "post";
        this.SECONDARY_METHOD = "patch";
        this._initButtonActions();
    }

    _initButtonActions() {
        const _this = this;
        $(`#${_this.approveID}, #${_this.rejectID}`).on("click", function(event){
            event.preventDefault();
            const $rowToRemove = $(this).closest("tr");
            _this._buttonClickStrategy(event.currentTarget.id, event.currentTarget.dataset[_this.sarDataAttr], $rowToRemove)
        });
    }

    _buttonClickStrategy(actionID, sarDbID, $rowToRemove) {
        this._updateSARStatus(this.actions[actionID], sarDbID, $rowToRemove)
    }

    _updateSARStatus(action, sarID, $elementToRemove) {
        const _this = this;
        $.ajax({
            url: `${_this.BASE_URL}${sarID}`,
            method: _this.PRIMARY_METHOD,
            dataType: "json",
            data: {
                system_access_request: {
                    id: sarID,
                    state: action
                },
                _method: this.SECONDARY_METHOD
            },
            success(data) {
               $elementToRemove.fadeOut("slow");
            },
            error(data) {
                console.log(data.statusText);
                $(".sar-error-container").html(data.statusText);
                $("#sar-error-modal").modal("open");
            }
        });
    }

}

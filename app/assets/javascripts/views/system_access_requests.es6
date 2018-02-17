$(document).on('turbolinks:load', function() {
    new SystemAccessRequestTable("sar-table", "sarId", "approve-sar", "reject-sar");
});

class SystemAccessRequestTable {
    constructor(tableID, dataAttribute, approveID, rejectID) {
        this.tableID = tableID;
        this._initialize();
        this.sysAccStatUp = new SystemAccessStatusUpdate(dataAttribute, approveID, rejectID)
    }

    _initialize() {
        this._initDataTable();
    }

    _initDataTable() {
        $(`#${this.tableID}`).dataTable({
            "bPaginate": false,
            "bLengthChange": false,
            "bFilter": true,
            "bInfo": false,
            "language": {
                "emptyTable": "No system access requests with this status currently exist. "
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
        this.actions = {
            `${this.rejectId`}: "reject",
            `${this.approveId`}: "approve"
        };
        this.url = '';
        this._initButtonActions();
    }

    _initButtonActions() {
        const _this = this;
        $(`#${_this.approveID}, #${_this.rejectID}`).on('click', function(event){
            event.preventDefault();
            _this._buttonClickStrategy(event.currentTarget.id, event.currentTarget.dataset[_this.sarDataAttr])
        });
    }

    _buttonClickStrategy(actionID, sarDbID) {
        
    }

    _updateSARStatus(url, action, sarID) {
        $.ajax({
            url: url,
            method: 'POST',
            dataType: 'json',
            data: {
                id: sarID,
                action: action,
                _method: 'PATCH'
            },
            success(data) {
               //remove that id from the dom
            },
            error(data) {
               //show error modal
            }
        });
    }

}

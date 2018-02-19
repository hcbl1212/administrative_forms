$(document).on('turbolinks:load', function() {
    new SystemAccessRequestForm(500, 400, 300)
});

class SystemAccessRequestForm {
    constructor(dropDownInDur , dropDownOutDur, requiredDelay) {
        this.dropDownInDur = dropDownInDur;
        this.dropDownOutDur = dropDownOutDur;
        this.requiredDelay = requiredDelay;
        this._initialize();
    }

    _initialize() {
        this._initToolTip();
        this._initDropDowns();
        this._initMaterialSelect();
        this._initDepartmentOtherText();
    }

    _initToolTip() {
        $('.required').tooltip({delay: this.requiredDelay});
    }

    _initDropDowns() {
        $(".button-collapse").sideNav();
        $('.dropdown-button, .mobile-dropdown-button').dropdown({
            inDuration: this.dropDownInDur,
            outDuration: this.dropDownOutDur,
        });
    }

    _initMaterialSelect() {
        $('select').material_select();
        this._styleDateSelect();
    }

    _styleDateSelect() {
       $('.row').find('span.effective-date').find('.select-wrapper').addClass('col s4');
    }

    _initDepartmentOtherText() {
        const _this = this;
        $("#employee_system_access_requests_attributes_0_department_ids_11").on("click", function(event) {
                _this._toggleDepartmentOtherText($(this).parent());
        });
    }

    _toggleDepartmentOtherText($parent) {
        if(!$parent.find("#other-text-input-div").length) {
            this._addOtherTextInput($parent);
        } else {
            this._removeOtherTextInput($parent);
        }
    }

    _addOtherTextInput($parent) {
        let $boilerPlateInputDiv = $('<div class="input-field" id="other-text-input-div"></div>');
        let $boilerPlateInput = $('<input type="text"' +
                            'name="employee[system_access_requests_attributes][0][departments][11][other_text]"'+
                             'id="employee_system_access_requests_attributes_0_departments_11_other_text"></input>')
        let $boilerPlateLabel = $('<label for="employee_system_access_requests_attributes_0_departments_11_other_text">Other Reason</label>');
        $boilerPlateInputDiv.append($boilerPlateInput, $boilerPlateLabel);
        $parent.append($boilerPlateInputDiv);
    }

    _removeOtherTextInput($parent) {
        $parent.find("#other-text-input-div").remove();
    }
}

$(document).on('turbolinks:load', function() {
    $.when($('select').material_select()).then(function() {
       $('.row').find('span.effective-date').find('.select-wrapper').addClass('col s4');
    });
    $('.required').tooltip({delay: 50});
    $(".button-collapse").sideNav();
    $('.dropdown-button').dropdown({
        inDuration: 300,
        outDuration: 225,
    });
    $('.mobile-dropdown-button').dropdown({
        inDuration: 300,
        outDuration: 225,
    });

    $("#employee_system_access_requests_attributes_0_department_ids_11").
        on("click", function(event) {
            toggleDepartmentOtherText($(this).parent());
    });

});

var toggleDepartmentOtherText = function($parent) {
    if(!$parent.find("#other-text-input-div").length) {
        addOtherTextInput($parent);
    } else {
        removeOtherTextInput($parent);
    }
};

var addOtherTextInput = function($parent) {
    let $boilerPlateInputDiv = $('<div class="input-field" id="other-text-input-div"></div>');
    let $boilerPlateInput = $('<input type="text"' +
                            'name="employee[system_access_requests_attributes][0][departments][11][other_text]"'+
                             'id="employee_system_access_requests_attributes_0_departments_11_other_text"></input>')
    let $boilerPlateLabel = $('<label for="employee_system_access_requests_attributes_0_departments_11_other_text">Other Reason</label>');
    $boilerPlateInputDiv.append($boilerPlateInput, $boilerPlateLabel);
    let $this = $(this);
    $parent.append($boilerPlateInputDiv);
};

var removeOtherTextInput = function($parent) {
   $parent.find("#other-text-input-div").remove();
};

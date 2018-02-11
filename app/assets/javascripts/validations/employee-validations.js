$(document).on('turbolinks:load', function() {
    var systemAccessFormValidator = $('#system-access-form').validate({
        invalidHandler: function(form, validator) {
            var errors = validator.numberOfInvalids();
            if (errors) {
                validator.errorList[0].element.focus(); //Set Focus
            }
        },
        rules: {
            'employee[employee]': {
                required: true
            },
            'employee[first_name]': {
                required: true
            },
            'employee[last_name]': {
                required: true
            },
            'employee[system_access_requests_attributes][0][reason]': {
                required: true
            },
            'employee[employee_email]': {
                required: "#employee_system_access_requests_attributes_0_system_access_field_ids_12:checked"
            },
            'employee[system_access_requests_attributes][0][softwares][1][roles][role_ids]': {
                required: "#employee_system_access_requests_attributes_0_softwares_1_id:checked"
            },
            'employee[system_access_requests_attributes][0][softwares][2][roles][role_ids]': {
                required: "#employee_system_access_requests_attributes_0_softwares_2_id:checked"
            },
            'employee[system_access_requests_attributes][0][softwares][3][roles][role_ids]': {
                required: "#employee_system_access_requests_attributes_0_softwares_3_id:checked"
            },
            'employee[system_access_requests_attributes][0][business_justification]': {
                required: function(element) {
                    return $("#employee_system_access_requests_attributes_0_privileged_access").val()!="";
                }
            }
        },
        messages: {
            'employee[employee_email]': {
                required: 'All sales reps must have emails.'
            }
        }
    });
});

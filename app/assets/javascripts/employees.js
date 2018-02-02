$(document).ready(function() {
    $.when($('select').material_select()).then(function() {
       $('.row').find('span.effective-date').find('.select-wrapper').addClass('col s4');
    });
$.validator.setDefaults({
    errorClass: 'invalid',
    validClass: "valid",
    errorPlacement: function (error, element) {
        $(element).closest("form").find("label[for='" + element.attr("id") + "']").attr('data-error', error.text());
    }
});
    var systemAccessFormValidator = $('#system-access-form').validate({
        rules: {
            'employee[employee]': {
                required: true
            },
            'employee[first_name]': {
                required: true
            },
            'employee[last_name]': {
                required: true
            }
        }
    });
});

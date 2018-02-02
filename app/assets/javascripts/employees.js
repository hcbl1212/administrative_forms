$(document).ready(function() {
    $.when($('select').material_select()).then(function() {
       $('.row').find('span.effective-date').find('.select-wrapper').addClass('col s4');
    });
    var systemAccessFormValidator = $('#system-access-form').validate({
        rules: {
            'employee[employee]': {
                required: true 
            }
        },
        errorPlacement: function(error, element) {
            if (element.is(":radio")) {
                console.log("here");
                error.insertAfter( element.parents('.row').children('div').last());
            } else { // This is the default behavior 
               error.insertAfter(element);
            }
        }

    });

});

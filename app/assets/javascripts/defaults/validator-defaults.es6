$(document).on('turbolinks:load', function() {
    $.validator.setDefaults({
        errorClass: 'invalid',
        validClass: "valid",
        errorPlacement: function (error, element) {
            let $input = $(element);
            $input.closest("form").find("label[for='" + element.attr("id") + "']").attr('data-error', error.text());
        }
    });
});

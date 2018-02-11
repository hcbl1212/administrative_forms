$(document).on('turbolinks:load', function() {
    $.when($('select').material_select()).then(function() {
       $('.row').find('span.effective-date').find('.select-wrapper').addClass('col s4');
    });

    $('.required').tooltip({delay: 50});
    $('.dropdown-button').dropdown({
        inDuration: 300,
        outDuration: 225,
    });
});

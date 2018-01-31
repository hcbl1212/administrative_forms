$(document).ready(function() {
    $.when($('select').material_select()).then(function() {
       $('.row').find('span.effective-date').find('.select-wrapper').addClass('col s4');
    });
});

$(document).on('turbolinks:load', function() {
    $("#sar-table").dataTable({
        "bPaginate": false,
        "bLengthChange": false,
        "bFilter": true,
        "bInfo": false,
        "language": {
            "emptyTable": "No system access requests with this status currently exist. "
        }
    });
});

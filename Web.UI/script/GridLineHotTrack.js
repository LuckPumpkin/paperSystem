$(function () {
    $("table[class=dataTable]").find('tr').not("tr[class=headerRow]").mouseover(function () {
        $(this).addClass("highlightRow");
    });
    $("table[class=dataTable]").find('tr').not("tr[class=headerRow]").mouseout(function () {
        $(this).removeClass("highlightRow");
    });
});
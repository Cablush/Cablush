$(function() {
    if ($('.pagination').length) {
        $(window).scroll(function () {
            var url;
            url = $('.pagination a[rel=next]').attr('href');
            if (url && $(window).scrollTop() > ($(document).height() / 2) - $(window).height() - 50) {
                $('.pagination').text('Fetching more products...');
                return $.ajax({
                    url: url,
                    dataType: "script"
                });
            }
        });
    }
    return $(window).scroll();
});

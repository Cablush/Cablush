$body = $("body");

$(document).on({
    ajaxStart: function () {
        $body.addClass("loading");
    },
    ajaxStop: function () {
        $body.removeClass("loading");
    }
});

$(function() {
    $('fieldset.collapsible .content').hide();
    $('fieldset.collapsible legend').click(function(){
        $(this).parent().find('.content').slideToggle("slow");
    });
});
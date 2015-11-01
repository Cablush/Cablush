// Default to JSON responses for remote calls
$.ajaxSetup({
    dataType: 'json'
});

// Loading...
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
    
    // Collapsible Fieldset
    $('fieldset.collapsible .content').hide();
    $('fieldset.collapsible legend').click(function(){
        $(this).parent().find('.content').slideToggle("slow");
    });
    
    // Field Masks
    var brTelMaskBehavior = function (val) {
        return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
    },
    brOptions = {
        onKeyPress: function(val, e, field, options) {
            field.mask(brTelMaskBehavior.apply({}, arguments), options);
        }
    };
    $('.maskTel').mask(brTelMaskBehavior, brOptions);
    $(".maskCep").mask('00000-000');
    $(".maskData").mask('00/00/0000');
    
});
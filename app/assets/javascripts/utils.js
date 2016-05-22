var Utils = (function($) {

    var body = null;

    var clearMessage = function() {
        $("#flash_messages").html("");
    };

    var showMessage = function(type, message) {
        $("#flash_messages").html('<div class="alert alert-' + type + '">' + message + '</div>');
    };

    var openPopup = function(aClass, name) {
        $(aClass).click(function(e) {
            e.preventDefault();
            var width  = 575,
                height = 400,
                left   = ($(window).width()  - width)  / 2,
                top    = ($(window).height() - height) / 2,
                url    = this.href,
                opts   = 'status=1' +
                         ',width='  + width  +
                         ',height=' + height +
                         ',top='    + top    +
                         ',left='   + left;
            window.open(url, name, opts);
        });
    };

    var startLoading = function() {
        if (body != null) {
            $(body).addClass("loading");
        }
    };

    var stopLoading = function() {
        if (body != null) {
            $(body).removeClass("loading");
        }
    };

    var setup = function() {
        body = $('body');

        $(document).on({
            ajaxStart: function () {
                //startLoading();
            },
            ajaxStop: function () {
                stopLoading();
            }
        });
    };

    var initDialog = function() {
        $(".dialog").dialog({
            autoOpen: false,
            modal: true,
            width: 425,
            resizable: false,
            position: {
                my: "center top",
                at: "center top",
                of: ".map" },
            close: function(event, ui) {
                $(".dialog").html("");
            }
        }).dialog("widget").find(".ui-dialog-title").hide();
    };

    var openDialog = function(data, onClose) {
        $(".dialog").html(data);
        if (typeof onClose === "function") {
            $(".dialog").on("dialogclose", function(event, ui) {
                onClose();
            });
        }
        $(".dialog").dialog("open");
    };

    var updateMetaTags = function(url, title, description, image) {
        $('meta[property=og\\:url]').attr('content', url
            ? url : 'http://www.cablush.com');
        $('meta[property=og\\:title]').attr('content', title
            ? title : 'Cablush - Esportes, lugares e eventos.');
        $('meta[property=og\\:description]').attr('content', description
            ? description : 'Cablush é um site colaborativo, para te ajudar a encontrar lojas, eventos e lugares onde praticar o seu esporte favorito.');
        $('meta[property=og\\:image]').attr('content', image
            ? image : window.facebook_cover);
    };

    return {
        setup: setup,
        startLoading: startLoading,
        stopLoading: stopLoading,
        showMessage: showMessage,
        clearMessage: clearMessage,
        openPopup: openPopup,
        initDialog: initDialog,
        openDialog: openDialog,
        updateMetaTags: updateMetaTags
    };

})(jQuery);

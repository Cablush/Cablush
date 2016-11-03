var Utils = (function($) {

    var body = null;

    var clearMessage = function() {
        $("#flash_messages").html("");
    };

    var showMessage = function(type, message) {
        $("#flash_messages").html('<div class="alert alert-' + type
                                + '" style="z-index:2">' + message + '</div>');
        window.scrollTo(0, 0);
    };

    var _convertResponseMessage = function(responseMessage) {
        if (responseMessage instanceof String) {
            return responseMessage;
        }
        var convertedMessage = "";
        $.each(responseMessage, function(field, messages) {
            convertedMessage += messages + '</br>';
        });
        return convertedMessage;
    };

    var showResponse = function(data) {
        var message = _convertResponseMessage(data.message);
        if (message && message.length !== 0) {
            showMessage(data.success ? 'success' : 'error', message);
        }
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
            clearMessage();
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
        $.fn.serializeObject = function() {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name] !== undefined) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };
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

    var initModal = function() {
        $(".modal").dialog({
            autoOpen: false,
            modal: true,
            width: 550,
            resizable: false,
            close: function(event, ui) {
                $(".modal").html("");
            }
        }).dialog("widget").find(".ui-dialog-title").hide();
    };

    var openModal = function(data, onClose) {
        $(".modal").html(data);
        if (typeof onClose === "function") {
            $(".modal").on("dialogclose", function(event, ui) {
                onClose();
            });
        }
        $(".modal").dialog("open");
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

    var _processYouTube = function(id, success) {
        if (!id) {
            throw new Error('Unsupported YouTube URL');
        }
        success('http://i2.ytimg.com/vi/' + id + '/hqdefault.jpg');
    };

    var getVideoThumb = function(url, success) {
        var id;
        url = url.replace(/.*?:\/\//g, "");
        if (url.indexOf('youtube.com') > -1) {
            id = url.split('/')[1].split('v=')[1].split('&')[0];
            return _processYouTube(id, success);
        } else if (url.indexOf('youtu.be') > -1) {
            id = url.split('/')[1];
            return _processYouTube(id, success);
        } else if (url.indexOf('vimeo.com') > -1) {
            if (url.match(/^vimeo.com\/[0-9]+/)) {
                id = url.split('/')[1];
            } else if (url.match(/^vimeo.com\/channels\/[\d\w]+#[0-9]+/)) {
                id = url.split('#')[1];
            } else if (url.match(/vimeo.com\/groups\/[\d\w]+\/videos\/[0-9]+/)) {
                id = url.split('/')[4];
            } else {
                throw new Error('Unsupported Vimeo URL');
            }
            $.ajax({
                url: 'http://vimeo.com/api/v2/video/' + id + '.json',
                dataType: 'jsonp',
                success: function(data) {
                    success(data[0].thumbnail_large);
                }
            });
        } else {
            throw new Error('Unrecognised URL');
        }
    };

    var dynamicNavigation = function(url, title) {
        if (url) {
            window.history.pushState(
                {"html": url, "pageTitle": title},
                title,
                url);
        } else {
            window.history.back();
        }
    };

    return {
        setup: setup,
        startLoading: startLoading,
        stopLoading: stopLoading,
        showMessage: showMessage,
        showResponse: showResponse,
        clearMessage: clearMessage,
        openPopup: openPopup,
        initDialog: initDialog,
        openDialog: openDialog,
        initModal: initModal,
        openModal: openModal,
        updateMetaTags: updateMetaTags,
        getVideoThumb: getVideoThumb,
        dynamicNavigation: dynamicNavigation
    };

})(jQuery);

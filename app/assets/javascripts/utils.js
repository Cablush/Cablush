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
        
        // Default to JSON responses for remote calls
        $.ajaxSetup({
            dataType: 'json'
        });
    
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
    
    var openDialog = function(url) {
        $(".dialog").load(url);
        $(".dialog").dialog("open");
    };
    
    return {
        setup: setup,
        startLoading: startLoading,
        stopLoading: stopLoading,
        showMessage: showMessage,
        clearMessage: clearMessage,
        openPopup: openPopup,
        initDialog: initDialog,
        openDialog: openDialog
    };

})(jQuery);
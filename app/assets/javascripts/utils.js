var Utils = (function($) {
    
    var body = null;
    
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
    
    return {
        setup: setup,
        startLoading: startLoading,
        stopLoading: stopLoading
    };

})(jQuery);
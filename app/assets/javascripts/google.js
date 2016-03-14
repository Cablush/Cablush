var Google = (function($) {
    
    var auth2 = null;
    
    var _initSDK = function() {
        if (null == gapi) {
            window.setTimeout(_initSDK,1000);
            return;
        }
        gapi.load('auth2', function() {
            auth2 = gapi.auth2.init({
                client_id: window.google_key
            });
        });
        loadAuth();
    };
    
    var _signInCallback = function(authResult) {
        if (authResult['code']) {
            $.get("/omniauth/google_oauth2/callback", authResult, function(data, status, xhr) {
                // response from server
            }, "html");
        }
    };

    var loadSDK = function() {
        $.ajaxSetup({ cache: true });
        $.getScript("//apis.google.com/js/client:plus.js", function() {
            _initSDK();
        });
    };
    
    var loadAuth = function() {
        $('.google_signin').on('click', function(e) {
            e.preventDefault();
            auth2.grantOfflineAccess({'redirect_uri': 'postmessage'}).then(_signInCallback);
        });
    };

    return {
        loadSDK: loadSDK,
        loadAuth: loadAuth
    };
    
})(jQuery);
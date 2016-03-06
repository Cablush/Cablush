var Facebook = (function($) {
    
    var fb_root = null;
    var fb_events_bound = false;
    
    var _bindFacebookEvents = function () {
        $(document).on('page:fetch', _saveFacebookRoot);
        $(document).on('page:change', _restoreFacebookRoot);
        $(document).on('page:load', function() {
            if (FB) {
                FB.XFBML.parse();
            }
        });
        fb_events_bound = true;
    };

    var _saveFacebookRoot = function() {
        fb_root = $('#fb-root').detach();
    };

    var _restoreFacebookRoot = function() {
        if($('#fb-root').length > 0) {
            $('#fb-root').replaceWith(fb_root);
        } else {
            $('body').append(fb_root);
        }
    };
    
    var _initFacebookSDK = function() {
        FB.init({
            appId      : window.facebook_key,
            status     : true, // check login status
            cookie     : true, // enable cookies to allow the server to access the session
            xfbml      : true,  // parse XFBML
            version    : 'v2.5'
        });
    };

    var loadFacebookSDK = function() {
        $.ajaxSetup({ cache: true });
        $.getScript("//connect.facebook.net/pt_BR/sdk.js#xfbml=1&version=v2.5", function() {
            _initFacebookSDK();
        });
        if (!fb_events_bound) {
            _bindFacebookEvents();
        }
    };
    
    var configFacebookAuth = function() {
        $('.fb_signin').on('click', function(e) {
            e.preventDefault();

            FB.login(function(response) {
                if (response.authResponse) {
                    console.log(response);
                    // since we have cookies enabled, this request will allow omniauth to parse
                    // out the auth code from the signed request in the fbsr_XXX cookie
                    $.getJSON('/omniauth/facebook/callback', function(json) {
                        $('#results').html(JSON.stringify(json));
                        // Do some other stuff here (call more json, load in more elements, etc)
                    });
                }
            }, { scope: 'email' }); // These are the permissions you are requesting
        });
    };

    return {
        loadSDK: loadFacebookSDK,
        loadAuth: configFacebookAuth
    };
    
})(jQuery);

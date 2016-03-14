var Facebook = (function($) {
    
    var fb_root = null;
    var fb_events_bound = false;
    
    var _bindEvents = function () {
        $(document).on('page:fetch', _saveRoot);
        $(document).on('page:change', _restoreRoot);
        $(document).on('page:load', function() {
            if (FB) {
                FB.XFBML.parse();
            }
        });
        fb_events_bound = true;
    };

    var _saveRoot = function() {
        fb_root = $('#fb-root').detach();
    };

    var _restoreRoot = function() {
        if($('#fb-root').length > 0) {
            $('#fb-root').replaceWith(fb_root);
        } else {
            $('body').append(fb_root);
        }
    };
    
    var _initSDK = function() {
        FB.init({
            appId      : window.facebook_key,
            status     : true, // check login status
            cookie     : true, // enable cookies to allow the server to access the session
            xfbml      : true, // parse XFBML
            version    : 'v2.5'
        });
    };

    var loadSDK = function() {
        $.ajaxSetup({ cache: true });
        $.getScript("//connect.facebook.net/pt_BR/sdk.js#xfbml=1&version=v2.5", function() {
            _initSDK();
        });
        if (!fb_events_bound) {
            _bindEvents();
        }
    };
    
    var configAuth = function() {
        $('.fb_signin').on('click', function(e) {
            e.preventDefault();

            FB.login(function(response) {
                if (response.authResponse) {
                    // since we have cookies enabled, this request will allow omniauth to parse
                    // out the auth code from the signed request in the fbsr_XXX cookie
                    $.get('/omniauth/facebook/callback', function(data, status, xhr) {
                        // response from server
                    }, "html");
                }
            }, { scope: 'email' }); // These are the permissions you are requesting
        });
    };
    
    var configFeed = function(name, link, picture, caption, description) {
        $('.fb_share').on('click', function(e) {
            e.preventDefault();
            FB.ui({
                method: 'feed',
                display: 'popup',
                name: name,
                link: link,
                picture: picture,
                caption: caption,
                description: description
            }, function(response){
                console.log(response);
                if (response && response.post_id) {
                    Utils.showMessage('success', 'Post was published.');
                } else {
                    Utils.showMessage('alert', 'Post was not published.');
                }
            });
        });
    };
    
    return {
        loadSDK: loadSDK,
        loadAuth: configAuth,
        loadFeed: configFeed
    };
    
})(jQuery);

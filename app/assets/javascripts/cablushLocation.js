var CablushLocation = (function($) {
    
    var _COOKIE_MY_LOCATION = "_cablush_my_location";
    
    var isDefaultLocation = function() {
        return $.cookie(_COOKIE_MY_LOCATION) != null;
    };
    
    var setDefaultLocation = function(latitude, longitude) {
        $.cookie.json = true;
        $.cookie(_COOKIE_MY_LOCATION, {lat: latitude, lng: longitude});
    };
    
    var getDefaultLocation = function() {
        if (isDefaultLocation()) {
            $.cookie.json = true;
            return $.cookie(_COOKIE_MY_LOCATION);
        } else {
            return {lat: -19.9025412, lng: -44.0340903};
        }
    };
    
    return {
        isDefaultLocation : isDefaultLocation,
        setDefaultLocation : setDefaultLocation,
        getDefaultLocation : getDefaultLocation
    };
    
})(jQuery);

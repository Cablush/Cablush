var CablushStaticMap = (function(CablushLocation) {
    
    var _mapElement;
    
    var _showMap = function(position) {
        var img_url = "https://maps.googleapis.com/maps/api/staticmap?center=" + position
                    + "&zoom=10&size=600x200&scale=2"
                    + "&markers=icon:http://www.cablush.com" + window.maps_mark_orange + "%7C" + position
                    + "&key=" + window.api_key;
        _mapElement.innerHTML = "<img src='"+img_url+"'>";
    };
    
    var _showDefaultLocation = function() {
        var location = CablushLocation.getDefaultLocation();
        _showMap(location.lat + "," + location.lng);
    };

    var _showCurrentLocation = function(location) {
        CablushLocation.setDefaultLocation(location.coords.latitude, location.coords.longitude);
        _showMap(location.coords.latitude + "," + location.coords.longitude);
    };

    var _geoError = function(error) {
        console.log("Geolocation error:" + error.code);
        _showDefaultLocation();
    };

    var _geoOptions = {
        maximumAge: 600000,
        timeout: 10000
    };

    var showMap = function(mapElement) {
        _mapElement = mapElement;
        if (navigator.geolocation && !CablushLocation.isDefaultLocation()) {
            navigator.geolocation.getCurrentPosition(_showCurrentLocation, _geoError, _geoOptions);
        } else {
            _showDefaultLocation();
        }
    };
        
    return {
        show : showMap        
    };
    
})(CablushLocation);

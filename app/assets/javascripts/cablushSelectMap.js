var CablushSelectMap = (function(CablushMap, CablushLocation) {
    
    var _mapElement;
    var _initLocation;
    var _map;
    var _marker;
    
    var _setMarker = function(position) {
        _marker = CablushMap.createCustomMarker(_map, "", position);
        _map.setCenter(_marker.getPosition());
        _map.setZoom(15);
    };

    var _removeMarker = function() {
        if (_marker) {
            _marker.setMap(null);
            _marker = null;
        }
    };
    
    var _showMap = function() {
        var mapOptions = {
            center: CablushLocation.getDefaultLocation(),
            zoom: 10,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            panControl: false,
            zoomControl: true,
            zoomControlOptions: {
                style: google.maps.ZoomControlStyle.LARGE,
                position: google.maps.ControlPosition.RIGHT_CENTER
            },
            mapTypeControl: false,
            scaleControl: false,
            streetViewControl: false
        };
        _map = new google.maps.Map(_mapElement, mapOptions);
        if (_initLocation) {
            _setMarker(new google.maps.LatLng(_initLocation.lat, _initLocation.lng));
        }
        _map.addListener('click', function(e) {
            _removeMarker();
            _setMarker(e.latLng);
            CablushSelectMap.setCoords(e.latLng.lat(), e.latLng.lng());
        });
    };
    
    var initMap = function(mapElement, latitude, longitude) {
        _mapElement = mapElement;
        if (latitude !== '0.0' && longitude !== '0.0') {
            _initLocation = {lat: latitude, lng: longitude};
        }
        CablushMap.createMap("showMap");
        window.showMap = _showMap;
    };
    
    var setAddress = function(address) {
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode({'address': address}, function(results, status) {
            if (status === google.maps.GeocoderStatus.OK) {
                _setMarker(results[0].geometry.location);
                CablushSelectMap.setCoords(_marker.getPosition().lat(), _marker.getPosition().lng());
            } else {
                console.log('Geocode error: ' + status);
            }
        });
    };
    
    return {
        init: initMap,
        setAddress: setAddress,
        setCoords: function(latitude, longitude){}
    };
    
})(CablushMap, CablushLocation);

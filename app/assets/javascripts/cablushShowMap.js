var CablushShowMap = (function(CablushMap, CablushLocation, $) {
    
    var _mapElement;
    var _locations;
    var _map;
    var _markers = [];
    
    var _clearMarkers = function() {
        for (var i = 0; i < _markers.length; i++) {
            _markers[i].setMap(null);
        }
        _markers = [];
    };
    
    var _centerMap = function() {
        var bounds = new google.maps.LatLngBounds();
        for (var i = 0; i < _markers.length; i++) {
            bounds.extend(_markers[i].getPosition());
        }
        if (!bounds.isEmpty()) {
            _map.fitBounds(bounds);
        }
    };

    var _showMap = function() {
        $(_mapElement).css({'height': "400px" });
        var mapOptions = {
            center: CablushLocation.getDefaultLocation(),
            zoom: 10
        };
        _map = new google.maps.Map(_mapElement, mapOptions);
        if (_locations) {
            loadLocations(_locations);
        }
    };
    
    var initMap = function(mapElement, locations) {
        _mapElement = mapElement;
        _locations = locations;
        CablushMap.createMap("showMap");
        window.showMap = _showMap;
    };
    
    var loadLocations = function(locations) {
        var infoWindow = new google.maps.InfoWindow();
        for (var i = 0; i < locations.length; i++) {
            var local = locations[i];
            if (local.latitude !== '0.0' && local.longitude !== '0.0') {
                var position = new google.maps.LatLng(local.latitude, local.longitude);
                var marker = CablushMap.createCustomMarker(_map, local.localizavel.nome, position);
                var infoContent = CablushMap.createInfoContent(local.localizavel.nome, local.localizavel.descricao, local.localizavel.logo);
                CablushMap.bindInfoWindow(marker, _map, infoWindow, infoContent);
                _markers.push(marker);
            }
        }
        _centerMap();
    };
    
    var clearLocations = function() {
        _locations = null;
        _clearMarkers();
    };
    
    return {
        init: initMap,
        loadLocations: loadLocations,
        clearLocations: clearLocations
    };
    
})(CablushMap, CablushLocation, jQuery);

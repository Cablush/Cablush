/* COMMON FUNCTIONS */
var createImage = function(url) {
    var image = {
        url: url,
        size: new google.maps.Size(21, 30),
        origin: new google.maps.Point(0,0),
        anchor: new google.maps.Point(0, 30)
    };
    return image;
};

var createCustomMarker = function(map, title, position) {
    var marker = new google.maps.Marker({
        position: position,
        map: map,
        title: title,
        icon: createImage(window.maps_mark)
    });
    return marker;
};

var createInfoWindow = function(title, text, logo) {
    var content = '<div class="infoContent"><h1 class="infoHeading">' + title + '</h1>'
                //+ (logo !== null ? '<div clas="infoLogo">' + logo + '</div>' : '')
                + '<div class="infoBody">' + text + '</div>'
                + '</div>';
    var infowindow = new google.maps.InfoWindow({
        content: content
    });
    return infowindow;
};

/* PESQUISAS (LOJAS, PISTAS e EVENTOS) */
var map;
var markers = [];
var locations = [];

var clearMarkers = function() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = [];
};

var setLocations = function() {
    clearMarkers();
    for (var i = 0; i < locations.length; i++) {
        var local = locations[i];
        if (local.latitude !== '0.0' && local.longitude !== '0.0') {
            var position = new google.maps.LatLng(local.latitude, local.longitude);
            var marker = createCustomMarker(map, local.localizavel.nome, position);
            markers.push(marker);
            var info = createInfoWindow(local.localizavel.nome, local.localizavel.descricao, local.localizavel.logo);
            google.maps.event.addListener(marker, 'click', function() {
                info.open(map, marker);
            });            
        }
    }
};

var centerMap = function() {
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0; i < markers.length; i++) {
        bounds.extend(markers[i].getPosition());
    }
    if (!bounds.isEmpty()) {
        map.fitBounds(bounds);
    }
};

var initMap = function() {
    $('#map-canvas').css({'height': "400px" });
    var mapOptions = {
        center: new google.maps.LatLng(-19.9025412, -44.0340903),
        zoom: 10
    };
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
    setLocations();
    centerMap();
};

/* CADASTROS (LOJAS, PISTAS e EVENTOS) */
var marker;

var setMarker = function(map, position) {
    marker = createCustomMarker(map, "", position);
    map.setCenter(marker.getPosition());
    map.setZoom(15);
};

var removeMarker = function() {
    if (marker) {
        marker.setMap(null);
        marker = null;
    }
};

var setCoords = function(latitude, longitude) {
    $('#local_latitude').val(latitude);
    $('#local_longitude').val(longitude);
};

var getAddress = function() {
    var addressArray = new Array(5);
    $('.geocode').each(function() {
        var id = $(this).attr('id').split("_").pop();
        switch (id) {
            case 'logradouro':
                addressArray[0] = $(this).val();
            break;
            case 'numero':
                addressArray[1] = $(this).val();
            break;
            case 'bairro':
                addressArray[2] = $(this).val();
            break;
            case 'cidade':
                addressArray[3] = $(this).find('option:selected').text();
            break;
            case 'estado':
                addressArray[4] = $(this).find('option:selected').text();
            break;
        }
    });
    return addressArray.filter(function(val) { 
        return val !== null && 0 !== val.length; 
    }).join(", ");
};

var geocodeAddress = function(geocoder, map) {
    geocoder.geocode({'address': getAddress()}, function(results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
            setMarker(map, results[0].geometry.location);
            setCoords(marker.getPosition().lat(), marker.getPosition().lng());
        } else {
            console.log('Geocode error: ' + status);
        }
    });
};

var initMapCad = function() {
    var mapOptions = {
        center: new google.maps.LatLng(-19.9025412, -44.0340903),
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
    var map = new google.maps.Map(document.getElementById('map-canvas-cad'), mapOptions);
    var geocoder = new google.maps.Geocoder();
    if ($('#local_latitude').val() !== '0.0' && $('#local_longitude').val() !== '0.0') {
        var position = new google.maps.LatLng($('#local_latitude').val(), $('#local_longitude').val());
        setMarker(map, position);
    }
    $('.geotrigger').on('change paste', function() {
        removeMarker();
        geocodeAddress(geocoder, map);
    });
    map.addListener('click', function(e) {
        removeMarker();
        setMarker(map, e.latLng);
        setCoords(e.latLng.lat(), e.latLng.lng());
    });
};

/* INDEX */
$(function() {
    if ($('body.home.index').length > 0) {
        var showStaticMap = function(location) {
            var position = "Belo Horizonte, Minas Gerasil, Brazil";
            if (location != null) {
                position = location.coords.latitude + "," + location.coords.longitude;
            }
            $('#map-canvas').css({'height': "400px" });
            var img_url = "https://maps.googleapis.com/maps/api/staticmap?center=" + position
                        + "&zoom=10&size=600x200&scale=2"
                        + "&markers=icon:http://www.cablush.com" + window.maps_mark + "%7C" + position
                        + "&key=" + window.api_key;
            document.getElementById("map-canvas").innerHTML = "<img src='"+img_url+"'>";
        };

        var geoError = function(error) {
            console.log("Geolocation error:" + error.code);
            showStaticMap();
        };

        var geoOptions = {
            maximumAge: 600000,
            timeout: 10000
        };

        var initStaticMap = function() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showStaticMap, geoError, geoOptions);
            } else {
                showStaticMap();
            }
        };

        initStaticMap();
    }
});
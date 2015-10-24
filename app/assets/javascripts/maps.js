// LOJAS, PISTAS e EVENTOS
var map;

var createImage = function(url) {
    var image = {
        url: url,
        size: new google.maps.Size(32, 32),
        origin: new google.maps.Point(0,0),
        anchor: new google.maps.Point(0, 32)
    };
    return image;
};

var createCustomMarker = function(coords, map, title) {
    var marker = new google.maps.Marker({
        position: coords,
        map: map,
        title: title,
        icon: createImage("/assets/cablush_21_30.jpg")
    });
    return marker;
};

function createInfoWindow(text) {
    var infowindow = new google.maps.InfoWindow({
        content: text
    });
    return infowindow;
}

function setLocations(locals) {
    for (var i = 0; i < locals.length; i++) {
        var local = locals[i];
        if (local.latitude !== null && local.longitute !== null) {
            var latLng = new google.maps.LatLng(local.latitude, local.longitute);
            var marker = createCustomMarker(latLng, map, local.nome);
            var info = createInfoWindow(local.descricao);
            google.maps.event.addListener(marker, 'click', function() {
                info.open(map, marker);
            });
        }
    }
}

var showMap = function(position) {
    var latLon = new google.maps.LatLng(-19.890723, -44.033203);
    if (position !== null) {
        latLon = new google.maps.LatLng(position.coords.latitude, position.coords.longitude); 
    }
    map = new google.maps.Map(document.getElementById('map-canvas'), {
        center: latLon,
        zoom: 12
    });
};

var geoError = function(error) {
    console.log(error);
    showMap();
};

var geoOptions = {
    maximumAge: 600000,
    timeout: 10000
};

var initMap = function() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showMap, geoError, geoOptions);
    } else {
        showMap();
    }
};

// INDEX
$(".home.index").ready(function () {
    
    var showStaticMap = function(position) {
        var latlon = "Belo Horizonte, Minas Gerasil, Brazil";
        if (position !== null) {
            latlon = position.coords.latitude + "," + position.coords.longitude;
        }
        var img_url = "https://maps.googleapis.com/maps/api/staticmap?center=" + latlon
                    + "&zoom=12&size=600x200&scale=2"
                    + (document.URL.contains("localhost") 
                        ? "&markers=color:0xE15A1F%7C" + latlon
                        : "&markers=icon:http://www.cablush.com/assets/cablush_21_30.jpg%7C" + latlon)
                    + "&key=AIzaSyDf2xE7rx47Ug-jAR2TgAycilb9Nmj6SyE";
        document.getElementById("map-canvas").innerHTML = "<img src='"+img_url+"'>";
    };
    
    var geoError = function(error) {
        console.log(error);
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
});
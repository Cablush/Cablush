// LOJAS, PISTAS e EVENTOS
var map;
var markers = [];
var locations = [];

var createImage = function(url) {
    var image = {
        url: url,
        size: new google.maps.Size(21, 30),
        origin: new google.maps.Point(0,0),
        anchor: new google.maps.Point(0, 30)
    };
    return image;
};

var createCustomMarker = function(title, latitude, longitude) {
    var marker = new google.maps.Marker({
        position: new google.maps.LatLng(latitude, longitude),
        map: map,
        title: title,
        icon: createImage("/assets/cablush_21_30.png")
    });
    return marker;
};

var clearMarkers = function() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = [];
};

function createInfoWindow(title, text, logo) {
    var content = '<div class="infoContent"><h1 class="infoHeading">' + title + '</h1>'
                //+ (logo !== null ? '<div clas="infoLogo">' + logo + '</div>' : '')
                + '<div class="infoBody">' + text + '</div>'
                + '</div>';
    var infowindow = new google.maps.InfoWindow({
        content: content
    });
    return infowindow;
}

function setLocations() {
    clearMarkers();
    for (var i = 0; i < locations.length; i++) {
        var local = locations[i];
        if (local.latitude !== '0.0' && local.longitude !== '0.0') {
            var marker = createCustomMarker(local.localizavel.nome, local.latitude, local.longitude);
            markers.push(marker);
            var info = createInfoWindow(local.localizavel.nome, local.localizavel.descricao, local.localizavel.logo);
            google.maps.event.addListener(marker, 'click', function() {
                info.open(map, marker);
            });            
        }
    }
}

var centerMap = function() {
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0; i < markers.length; i++) {
        bounds.extend(markers[i].getPosition());
    }
    if (!bounds.isEmpty()) {
        map.fitBounds(bounds);
    }
}

var initMap = function() {
    var mapOptions = {
        center: new google.maps.LatLng(-19.9025412, -44.0340903),
        zoom: 10
//        mapTypeId: google.maps.MapTypeId.ROADMAP,
//        panControl: true,
//        mapTypeControl: false,
//        panControlOptions: {
//            position: google.maps.ControlPosition.RIGHT_CENTER
//        },
//        zoomControl: true,
//        zoomControlOptions: {
//            style: google.maps.ZoomControlStyle.LARGE,
//            position: google.maps.ControlPosition.RIGHT_CENTER
//        },
//        scaleControl: false,
//        streetViewControl: false,
//        streetViewControlOptions: {
//            position: google.maps.ControlPosition.RIGHT_CENTER
//        }
    };

    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
    
    setLocations();
    centerMap();
};

// INDEX
$(".home.index").ready(function () {
    
    var showStaticMap = function(location) {
        var position = "Belo Horizonte, Minas Gerasil, Brazil";
        if (location !== null) {
            position = location.coords.latitude + "," + location.coords.longitude;
        }
        var img_url = "https://maps.googleapis.com/maps/api/staticmap?center=" + position
                    + "&zoom=12&size=600x200&scale=2"
                    + (document.URL.contains("localhost") 
                        ? "&markers=color:0xE15A1F%7C" + position
                        : "&markers=icon:http://www.cablush.com/assets/cablush_21_30.png%7C" + position)
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
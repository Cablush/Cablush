var CablushMap = (function() {
    
    var createMap = function(callbackName){
        var script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = 'https://maps.googleapis.com/maps/api/js?v=3' 
                   + '&key=' + window.api_key 
                   + '&callback=' + callbackName;
        document.body.appendChild(script);
    };
    
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

    var createInfoContent = function(title, text, logo) {
        var content = '<div class="infoContent"><h1 class="infoHeading">' + title + '</h1>'
                    //+ (logo !== null ? '<div clas="infoLogo">' + logo + '</div>' : '')
                    + '<div class="infoBody">' + text + '</div>'
                    + '</div>';
        return content;
    };

    var bindInfoWindow = function(marker, map, infoWindow, content) {
        google.maps.event.addListener(marker, 'click', function() {
            infoWindow.close();
            infoWindow.setContent(content);
            infoWindow.open(map, marker);
        });
    };
    
    return {
        createMap: createMap,
        createImage: createImage,
        createCustomMarker: createCustomMarker,
        createInfoContent: createInfoContent,
        bindInfoWindow: bindInfoWindow
    };
    
})();
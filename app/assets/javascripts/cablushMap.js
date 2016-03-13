var CablushMap = (function($) {
    
    var createMap = function(callbackName){
        var script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = 'https://maps.googleapis.com/maps/api/js?v=3' 
                   + '&key=' + window.api_key 
                   + '&callback=' + callbackName;
        document.body.appendChild(script);
    };
    
    var createImage = function(type) {
        var url = window.maps_mark_orange;
        switch (type) {
            case 'Evento':
                url = window.maps_mark_blue;
                break;
            case 'Loja':
                url = window.maps_mark_green;
                break;
            case 'Pista':
                url = window.maps_mark_orange;
                break;
        }
    
        var image = {
            url: url
        };
        return image;
    };
    
    var createCustomMarker = function(map, title, position, type) {
        var marker = new google.maps.Marker({
            position: position,
            map: map,
            title: title,
            icon: createImage(type)
        });
        return marker;
    };

    var createInfoContent = function(title, text, logo) {
        var content = '<div class="infoContent"><h1 class="infoHeading">' + title + '</h1>'
                    //+ (logo !== null ? '<div clas="infoLogo"><img alt="' + title + '" src="' + logo + '"></div>' : '')
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
    
    var initDialog = function() {
        $(".dialog").dialog({
            autoOpen: false,
            modal: true,
            width: 425,
            resizable: false,
            position: { 
                my: "center top", 
                at: "center top", 
                of: ".map" },
            close: function(event, ui) {
                $(".dialog").html("");
            }
        }).dialog("widget").find(".ui-dialog-title").hide();
    };
    
    var bindDialog = function(marker, map, url) {
        google.maps.event.addListener(marker, 'click', function() {
            $(".dialog").load(url);
            $(".dialog").dialog("open");
        });
    };
    
    return {
        createMap: createMap,
        createImage: createImage,
        createCustomMarker: createCustomMarker,
        createInfoContent: createInfoContent,
        bindInfoWindow: bindInfoWindow,
        initDialog : initDialog,
        bindDialog : bindDialog
    };
    
})(jQuery);

var google;
var map;
var markers = [];
function initialize() {
  var mapOptions = {
     zoom: 4,
     center: new google.maps.LatLng(-19.890723, -44.033203),
     mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  applyMarker(markers);
}

google.maps.event.addDomListener(window, 'load', initialize);

function applyMarker(markers){
  for(var i = 0; i < markers.length; i++){
    var location = markers[i];
  var latLng = new google.maps.LatLng(location[0], location[1]); 
  
		var marker=new google.maps.Marker({
  			position:latLng,
  			});
  			
		 marker.setMap(map);
    }
}

function setMarker(lat, lng){
 markers.push([lat, lng]) ;
}

google.maps.event.addDomListener(window, 'load', function(){
    navigator.geolocation.getCurrentPosition(initialize);
});


$(document).on("ready",function(){
  $('.modal-trigger').leanModal()
  if($('#branches_map').length){
    navigator.geolocation.getCurrentPosition(branchesLocation, onError)
  }
})

var map;

function branchesLocation(userPosition){

  latitude = [];
  $('.js-branch-lat').each(function(){
    var lat = $(this).data('branch-lat');
    latitude.push(lat);
  });

  longitude = [];
  $('.js-branch-long').each(function(){
    var long = $(this).data('branch-long');
    longitude.push(long);
  });

  var position = {
    lat: latitude,
    lng: longitude
   };

   var mapPosition = {
     lat: latitude[0],
     lng: longitude[0]
    };

   createBranchesMap(mapPosition);
   createBranchesMarker(position);
}

function createBranchesMap(position){
  var mapPosition = {
    lat: position.lat,
    lng: position.lng
   };
  var mapOptions = {
    center: position,
    zoom: 12
  };
  map = new google.maps.Map($('#branches_map')[0], mapOptions);
 }

function createBranchesMarker(position) {
  for (i = position.lat.length-1; i >= 0; i--){
    var markerPosition = {
      lat: position.lat[i],
      lng: position.lng[i]
     };
    var marker = new google.maps.Marker({
     position: markerPosition,
     map: map
     });
   }
}

function onError(err){
  console.log("What are you using, IE 7??", err);
}

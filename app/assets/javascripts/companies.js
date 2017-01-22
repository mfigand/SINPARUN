//
// $(document).on("ready",function(){
//   $('.modal-trigger').leanModal()
//   if($('#branches_map').length){
//     navigator.geolocation.getCurrentPosition(branchesLocation, onError)
//   }
// })
//
// var map;
//
// function branchesLocation(userPosition){
//   latitude = [];
//   $('.js-branch-lat').each(function(){
//     var lat = $(this).data('branch-lat');
//     latitude.push(lat);
//   });
//
//   longitude = [];
//   $('.js-branch-long').each(function(){
//     var long = $(this).data('branch-long');
//     longitude.push(long);
//   });
//
//   var position = {
//     lat: latitude,
//     lng: longitude
//    };
//
//    var mapPosition = {
//      lat: latitude[0],
//      lng: longitude[0]
//     };
//
//    createBranchesMap(mapPosition);
//    createBranchesMarker(position);
// }
//
// function createBranchesMap(position){
//   var mapPosition = {
//     lat: position.lat,
//     lng: position.lng
//    };
//   var mapOptions = {
//     center: position,
//     zoom: 12
//   };
//   map = new google.maps.Map($('#branches_map')[0], mapOptions);
//  }
//
// function createBranchesMarker(position) {
//   for (i = position.lat.length-1; i >= 0; i--){
//     var markerPosition = {
//       lat: position.lat[i],
//       lng: position.lng[i]
//      };
//
//     var marker = new google.maps.Marker({
//      position: markerPosition,
//      map: map
//      });
//    }
// }
//
// function onError(err){
//   console.log("What are you using, IE 7??", err);
// }


var google;

function initAccountantsMap() {

    if ("geolocation" in navigator) {
        /* geolocation is available */

        //Get user location
        navigator.geolocation.getCurrentPosition(function(position) {
            locateUser(position.coords.latitude, position.coords.longitude);
        });

        function locateUser(lat,lng) {
            //Create Map
            var styles = [
                {
                    stylers: [
                        { hue: "#00ffe6" },
                        { saturation: -20 }
                    ]
                },{
                    featureType: "road",
                    elementType: "geometry",
                    stylers: [
                        { lightness: 100 },
                        { visibility: "simplified" }
                    ]
                },{
                    featureType: "road",
                    elementType: "labels",
                    stylers: [
                        { visibility: "off" }
                    ]
                }
            ];

            var accountantsMap = new google.maps.Map(document.getElementById('branches_map'), {
                zoom: 13,
                scrollwheel: false,
                center: {lat: lat, lng: lng}
            });

            accountantsMap.setOptions({styles: styles});

            //Create user marker
            var myLatlng = new google.maps.LatLng(lat, lng);
            var pinColor = "ffff19";
            var pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor,
                new google.maps.Size(21, 34),
                new google.maps.Point(0, 0),
                new google.maps.Point(10, 34));
            var pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
                new google.maps.Size(40, 37),
                new google.maps.Point(0, 0),
                new google.maps.Point(12, 35));

            var userMarker = new google.maps.Marker({
                position: myLatlng,
                map: accountantsMap,
                icon: pinImage,
                shadow: pinShadow,
                animation: google.maps.Animation.DROP,
                title: 'My location'
            });

            //Info window appear when click User marker
            var contentStringUser = '<div id="content">' +
                '<h5 id="firstHeading" class="firstHeading">My location</h5>' +
                '</div>';

            var infowindowUser = new google.maps.InfoWindow({
                content: contentStringUser
            });

            userMarker.addListener('click', function () {
                infowindowUser.open(accountantsMap, userMarker);
            });

            locateAccountants();

            function locateAccountants() {
              var labels = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
              var latitude = [];
              var longitude = [];

              $('.js-branch-lat').each(function(){
                var lat = $(this).data('branch-lat');
                latitude.push(lat);
              });

              $('.js-branch-long').each(function(){
                var long = $(this).data('branch-long');
                longitude.push(long);
              });

              var position = {
                lat: latitude,
                lng: longitude
               };

               var locations = [];

               for(i = 0; i < latitude.length; i++){
                 locations.push(
                   {
                     lat: latitude[i],
                     lng: longitude[i]
                   }
                 )
               }

              //  var mapPosition = [{
              //    lat: latitude[0],
              //    lng: longitude[0]
              //  }];
               //
                var titles = [];
                var addresses = [];

                // Add Accountants markers to the accountantsMap.
                // Note: The code uses the JavaScript Array.prototype.map() method to
                // create an array of markers based on a given "locations" array.
                // The map() method here has nothing to do with the Google Maps API.
                var accountantsMarkers = locations.map(function (location, i) {
                    return new google.maps.Marker({
                        position: location,
                        label: labels[i % labels.length],
                        title: titles[i]
                    });

                });

                //Add info window to each marker
                for (i=0; i < accountantsMarkers.length; i++){
                    var marker = accountantsMarkers[i];
                    var content = '<h3 id="firstHeading">'+titles[i]+'</h3>'+'<div id="bodyContent">Address</div>';
                    var infowindow = new google.maps.InfoWindow();

                    google.maps.event.addListener(marker,'click', (function(marker,content,infowindow){
                        return function() {
                            infowindow.setContent(content);
                            infowindow.open(accountantsMap,marker);
                        };
                    })(marker,content,infowindow));
                }

                // Add a marker clusterer to manage the markers.
                var markerCluster = new MarkerClusterer(accountantsMap, accountantsMarkers,
                    {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});

                for (i=0; i < locations.length; i++){

                    var infowindow = new google.maps.InfoWindow({
                        size: new google.maps.Size(150, 50)
                    });
                    var content = '<h3 id="firstHeading" class="firstHeading">Name Branch</h3>'+
                        '<b>Addres Branch</b>';
                    var marker = accountantsMarkers[i];

                    google.maps.event.addListener(marker,'click', (function(marker,content,infowindow){
                        return function() {
                            infowindow.setContent(content);
                            infowindow.open(accountantsMap,marker);
                        };
                    })(marker,content,infowindow));
                }

            }
        }

    } else {
        /* geolocation IS NOT available */
        console.log('geolocation IS NOT available')
    }
}

google.maps.event.addDomListener(window, 'load', initAccountantsMap);

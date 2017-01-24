var google;

function initRewardsMap() {

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

            var rewardsMap = new google.maps.Map(document.getElementById('rewards_map2'), {
                zoom: 13,
                scrollwheel: false,
                center: {lat: lat, lng: lng}
            });

            rewardsMap.setOptions({styles: styles});

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
                map: rewardsMap,
                icon: pinImage,
                shadow: pinShadow,
                animation: google.maps.Animation.DROP,
                title: $('.js-user-name').data('user-name')
            });

            //Info window appear when click User marker
            var contentStringUser = '<div id="content">' +
                '<h5 id="firstHeading" class="firstHeading">'+$('.js-user-name').data('user-name')+'</h5>' +
                '</div>';

            var infowindowUser = new google.maps.InfoWindow({
                content: contentStringUser
            });

            userMarker.addListener('click', function () {
                infowindowUser.open(rewardsMap, userMarker);
            });

            locateRewards();

            function locateRewards() {
              var labels = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
              var latitude = [];
              var longitude = [];
              var companyName = [];
              var rewards = [];
              var locations = [];

              $('.js-rewards-name').each(function(){
                var rewardsName = $(this).data('rewards-name');
                rewards.push(rewardsName);
              });

              $('.js-rewards-lat').each(function(){
                var lat = $(this).data('rewards-lat');
                latitude.push(lat);
              });

              $('.js-rewards-long').each(function(){
                var long = $(this).data('rewards-long');
                longitude.push(long);
              });

              $('.js-company-name').each(function(){
                var name = $(this).data('company-name');
                companyName.push(name);
              });

              var position = {
                lat: latitude,
                lng: longitude
              };

              for(i = 0; i < latitude.length; i++){
                 locations.push(
                  {
                    lat: latitude[i],
                    lng: longitude[i]
                  }
                )
              }

              // Add Accountants markers to the rewardsMap.
                // Note: The code uses the JavaScript Array.prototype.map() method to
                // create an array of markers based on a given "locations" array.
                // The map() method here has nothing to do with the Google Maps API.
                var rewardsMarkers = locations.map(function (location, i) {
                    return new google.maps.Marker({
                        position: location,
                        label: labels[i % labels.length],
                        title: companyName[i]
                    });

                });

                //Add info window to each marker
                for (i=0; i < rewardsMarkers.length; i++){
                    var marker = rewardsMarkers[i];
                    var content = '<h5 id="firstHeading">'+companyName[i]+'</h5>'+'<div id="bodyContent">'+rewards[i]+'</div>';
                    var infowindow = new google.maps.InfoWindow();

                    google.maps.event.addListener(marker,'click', (function(marker,content,infowindow){
                        return function() {
                            infowindow.setContent(content);
                            infowindow.open(rewardsMap,marker);
                        };
                    })(marker,content,infowindow));
                }

                // Add a marker clusterer to manage the markers.
                var markerCluster = new MarkerClusterer(rewardsMap, rewardsMarkers,
                    {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});

            }
        }

    } else {
        /* geolocation IS NOT available */
        console.log('geolocation IS NOT available')
    }
}

google.maps.event.addDomListener(window, 'load', initRewardsMap);

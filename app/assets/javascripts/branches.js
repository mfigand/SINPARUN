$(document).on("ready",function(){
  if($('#branchMap').length){
    var branchName = $('.js-branch-name')[0].innerText;
    var branchRewards = [];
    branchLocation();
  }

  var map;

  function branchLocation(){
    var position = {
      lat: $('.js-latitude').data('lat'),
      lng: $('.js-longitude').data('lon')
    };

    createBranchMap(position);
  }

  function createBranchMap(position){
    var mapOptions = {
      center: position,
      zoom: 15
    };
    map = new google.maps.Map($('#branchMap')[0], mapOptions);
    createBranchMarker(position);
  }

  function createBranchMarker(position) {
    var marker = new google.maps.Marker({
     position: position,
     map: map,
       title:$('.js-branch-name')[0].innerText
     });
     marker.addListener('click', function() {
      infowindow.open(map, marker);
    });
  }

  var contentString = '<div id="content">'+
        '<div id="siteNotice">'+
        '</div>'+
        '<h1 id="firstHeading" class="firstHeading"></h4>'+
        '<div id="bodyContent">'+
        '<p><b>'+ branchName +'</b>'+
        '<p>'+branchRewards+'</p>'+
        '</div>'+
        '</div>';


  var infowindow = new google.maps.InfoWindow({
     content: contentString
   });

  function branchLocationError(err){
    console.log("What are you using, IE 7??", err);
  }

})

$(document).on("ready",function(){
  if($('.js-btn-nike').length){
    $(".js-btn-nike").on("click", getActivity);
  }
  if($('.js-btn-runtastic').length){
    $(".js-btn-runtastic").on("click", getActivityRuntastic);
  }
})

var getActivity = function (){
  $('.kms_counter').empty();
  $('.total_kms_counter').empty();
  $('.level_counter').empty();
  $('.races_counter').empty();

  var activity_request = $.get('/api_sinparun/nike');
  activity_request.done(get_kms);
  };

  function get_kms(response){
    var sync_acount = $.get('/users/sync_account/nike', response);
    sync_acount.done(get_kms_response);
    sync_acount.fail(get_kmsError);
  };

  function get_kms_response(kms_response){
    $(".message").text("updated synchronization");
    $(".kms_counter").text(kms_response.sinparun_kms);
    $(".total_kms_counter").text(kms_response.total_kms);
    $('.level_counter').text(kms_response.level);
    $('.races_counter').text(kms_response.races);
  };

  function get_kmsError(error){
    if (error.status == 406){
      $(".error").text(error.responseText)
    }
    else {
      $(".error").text("Sorry synchronization error")
    }
  };


  var getActivityRuntastic = function (){
    $('.kms_counter').empty();
    $('.total_kms_counter').empty();
    $('.level_counter').empty();
    $('.races_counter').empty();

    var activity_request = $.get('/api_sinparun/runtastic');
    activity_request.done(get_kms_runtastic);
    };

    function get_kms_runtastic(response_runtastic){
      var sync_acount = $.get('/users/sync_account/runtastic', response_runtastic);
      sync_acount.done(get_kms_runtastic_response);
      sync_acount.fail(get_kmsError);
    };

    function get_kms_runtastic_response(kms_response_runtastic){
      $(".message").text("updated synchronization");
      $(".kms_counter").text(kms_response_runtastic.sinparun_kms);
      $(".total_kms_counter").text(kms_response_runtastic.total_kms);
      $('.level_counter').text(kms_response_runtastic.level);
      $('.races_counter').text(kms_response_runtastic.races);
    };

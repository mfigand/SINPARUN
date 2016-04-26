$(document).on("ready",function(){
  $(".js-btn-validate").on("click", validateCoupon);

});

var validateCoupon = function (){
  $(".salute").empty();
  $(".error").empty();
  $(".response").empty();
  $(".reward_description").empty();
  var codeToValidate = {
    email:$('.email_to_validate').val(),
    code:$('.code_to_validate').val()
  }

  var request = $.get('/search_coupon', codeToValidate);
  request.done(modify_coupon);
  request.fail(couponError);
};

function couponError(error){
  if (error.status == 406){
    $(".error").text(error.responseText)
  }
  else {
    $(".error").text("Sorry coupon is not valid")
  }
};

function modify_coupon(response){
  $(".response").text("Code succesfully validated")
  $(".reward_description").text(response.description)
};

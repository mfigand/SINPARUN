$(document).on("ready",function(){
  var home_url = window.location.pathname.split("/")
  var uri = home_url[2] === "sign_in" || home_url[2] === "sign_up" || home_url[2] === undefined || home_url[3] === "edit"
  hideNav = function (){
    $('.nav_bar').hide();
    $('.panel').hide();
  }
  if (home_url[1] === "users" && uri ){
    hideNav();
    $('.home_body').addClass('users_body');
  }
  if (home_url[1] === "companies" && uri ){
    hideNav();
    $('.home_body').addClass('companies_body');
  }
  if (home_url[1] === "employees" && uri ){
    hideNav();
    $('.sing_up_link').hide();
    $('.home_body').addClass('employees_body');
  }
  if (home_url[0] === "" && home_url[1] === "" ){
    hideNav();
    $('.home_body').addClass('comun_body');
  }
})

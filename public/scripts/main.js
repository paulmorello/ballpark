
$('.responsive-menu').hide()


var menuDisplay = function() {
  $('#dropdown-menu').css('z-index', 1);
  $('.responsive-menu').slideToggle();
};


$('#menu-btn').mouseover(function(event) {

  menuDisplay();

});

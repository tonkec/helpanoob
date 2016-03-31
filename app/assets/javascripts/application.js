// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require best_in_place
//= require bootstrap-sass
//= require jquery-ui
//= require autocomplete-rails
//= require jquery-fileupload/basic
//= require_tree .
$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();

  function toggleNav () {
    $(".nav-container").toggleClass("showNav hideNav").removeClass("hidden");
    $(".btn-nav").toggleClass("animated");
  }
  $(".btn-nav").on("click tap", function() {
    toggleNav();
  });

 /*$(document).keyup(function(e) {
    if (e.keyCode == 27) {
     toggleNav();
   } 
 });*/
});
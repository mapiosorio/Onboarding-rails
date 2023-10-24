// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import $ from "jquery";

$('.heart').click(function() {
  if ($(this).hasClass('bi-heart')) {
    $(this).removeClass('bi-heart').addClass('bi-heart-fill');
    $(this).removeClass('text-white').addClass('text-danger');
  } else {
    $(this).removeClass('bi-heart-fill').addClass('bi-heart');
    $(this).removeClass('text-danger').addClass('text-white');
  }
});

  $('.filters').click(function() {

    console.log(this);
    if ($(this).hasClass('btn-outline-dark')) {
      console.log('entra');
      $(this).removeClass('btn-outline-dark').addClass('btn-dark');
    } else {
      $(this).removeClass('btn-dark').addClass('btn-outline-dark');
    }
  });


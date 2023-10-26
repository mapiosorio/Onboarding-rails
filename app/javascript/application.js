// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import $ from "jquery";


$(document).on('click', '.heart', function() {
  if ($(this).hasClass('bi-heart')) {
    $(this).removeClass('bi-heart').addClass('bi-heart-fill');
    $(this).removeClass('text-white').addClass('text-danger');
  } else {
    $(this).removeClass('bi-heart-fill').addClass('bi-heart');
    $(this).removeClass('text-danger').addClass('text-white');
  }
});

// Entry point for the build script in your package.json
//= require ckeditor/config
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import $ from "jquery";

$(document).on('click', '.heart', function() {
  $(this).toggleClass('bi-heart')
  $(this).toggleClass('bi-heart-fill')
  $(this).toggleClass('text-danger')
  $(this).toggleClass('text-white')
});

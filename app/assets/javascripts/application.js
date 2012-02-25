// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require ace/ace-uncompressed.js
//= require ace/theme-twilight.js
//= require ace/mode-ruby.js
//= require chosen-jquery
//= require_directory .

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "application/json")} 
});

$(function() {
  $("input:submit").button();

  $("input.tag-field").tagit({allowSpaces: true});

  $(".chosen").chosen();

  $("a.show-problem-info").live("click", function(e) {
    var self = $(e.target);
    if(self.text().match(/Show/)) {
      $(e.target).text("Hide...");
      $(e.target).parent().next(".problem-info").slideDown();
    } else {
      $(e.target).text("Show...");
      $(e.target).parent().next(".problem-info").slideUp();
    }

  });
});

$(document).ready(function(){

	// LOGIN PAGE
  if($('.portlet-login').length){
    $('body').addClass('login-page');

    var $container = $('.login-page #main-content > .row > .col-md-12');
    $container.removeClass('col-md-12');
    $container.addClass('col-xl-10 col-xl-push-3 col-sm-12 col-sm-push-2 col-xs-16 col-xs-push-0');
  }


  $('.journal-content-article *').removeAttr('style');
});
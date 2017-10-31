


$('input').change(function(){
  if($(this).val() !== ''){
    $(this).addClass('has-value');
  }
});

var $form = $('.portlet-forms');
if($form.length){ 

  $form.find('.ddl-form-builder-app').removeClass('container-fluid-1280');

  var onloadCallback = function() {
    grecaptcha.render('googleCaptcha', {
      'sitekey' : '6LfdLDYUAAAAAF3bQnWzW13pmwdEjazyGn579_Yx'
    });
  };

  var $form_info = $form.find('.ddl-form-basic-info');
  if($form_info.length){

    $form_title = $form_info.find('.ddl-form-name');
    if($form_title.length){
      $form_title.unwrap();
      $form_title.addClass('whitney-huge');
    }
    $form_description = $form_info.find('.ddl-form-description');
    if($form_description.length){
      $form_description.unwrap();
      $form_description.addClass('presna-normal');
    }
  }

  var $form_body = $form.find('.lfr-ddm-form-content');
  if($form_body.length){

    var $form_pages = $form_body.find('.lfr-ddm-form-page');
    $form_pages.each(function(){
      var $page = $(this);
      var $required_warning = $page.find('.required-warning').remove();
      $page.append($required_warning);
    });
  }
}

var $contact_form = $('.contact-us-page .lfr-ddm-form-page');
if($contact_form.length){

  // add section headers to form
  var $info_header = $(`
    <header>
      <hr>
      <h3 class="whitney-bold">Information</h3>
    </header>
  `);
  $contact_form.prepend($info_header);
  var $message_header = $(`
    <header>
      <hr>
      <h3 class="whitney-bold">Message</h3>
    </header>
  `);
  $contact_form.find('.row:nth-of-type(3)').after($message_header);

  $contact_form.find('.col-md-6').removeClass('col-md-6').addClass('col-xl-8');

  $contact_form.find('.row:nth-of-type(4) .col-xl-8:last-of-type').append('<div id="googleCaptcha"></div>');
  $.getScript("https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit", function(){});
}
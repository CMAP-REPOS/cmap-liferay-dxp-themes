var $old_header = $('.portlet-body .h2');
var $back = $old_header.find('.header-back-to a');
$back.find('.header-title').text('View all updates');
if($gross_layout.length){
    $gross_layout.find('col-xl-3:first-of-type').append($back.remove());
}

var $back =  $('.portlet-body .h2 .header-back-to a')
$back.find('span:first-of-type').addClass('icon').removeAttr('id');
$back.find('span:last-of-type').removeAttr('class').text('View all updates');
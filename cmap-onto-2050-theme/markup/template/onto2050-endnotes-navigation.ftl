<script>
$(function() {
    $('.endnotes-navigation').find('ul').html('');
    $('.section-sub-headline').each(function() {
        var anchor = $(this).find('a').prop('id');
        var title = $(this).find('button').text();
        $('.endnotes-navigation').find('ul')
            .append('<li><span class="whitney-small bold"><a href="#'+anchor+'" tabindex="0">' + title + '</a></span></li>')
    });
});
</script>

<div class="endnotes-navigation page-nav"> 
    <span class="widget-headline whitney-normal bold">${Header.getData()}</span> 
    <ul class="list-unstyled"> 
    </ul> 
</div>
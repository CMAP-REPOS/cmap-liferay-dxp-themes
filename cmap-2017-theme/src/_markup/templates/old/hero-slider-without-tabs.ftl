#foreach ( $config in $SliderConfiguration.getSiblings() )
  #set ( $slider_title = $config.title.data )
#end

<div class="slider-component">
  <div class="slide-container slider-hero slider-no-tabs row-fluid">
       #if ( $slider_title != "" )
         <h2 class="slider-title" title="$slider_title">$slider_title</h2>
       #end
        <div class="slides">
          #foreach($i in $SlideItem.getSiblings())

            ## Checking whether text color is black or white
            #if ( $i.TextColor.getData() != "" )
              #set ($text_color = $i.TextColor.getData())
            #else
              #set ($text_color = "default")
            #end

            ## Checking if title text color is defined
            #if ( $i.TitleTextColor.getData() != "" )
              #set ($title_text_color = $i.TitleTextColor.data)
            #else
              #set ($title_text_color = "default-title-text")
            #end

            ## Checking if title border color is defined
            #if ( $i.TitleBorderColor.getData() != "" )
              #set ($title_border_color = $i.TitleBorderColor.data)
            #else
              #set ($title_border_color = "default-title-border")
            #end

            <div class="slide $text_color $title_text_color $title_border_color" style="background-image: url($i.Image.getData());">
<div class="span10 row-fluid">
<div></div>
<div class="slide-description">
                    <h3>$i.Title.getData()</h3>
                    $i.Description.getData()
                #if ( $i.PhotoCreditText.getData() != "" )

                    <span class="photo-credit">
                    <span>
                        #set ($photo_credit_text = $i.PhotoCreditText.data)
                        #if ( $i.PhotoCreditLink.getData() != "" )
                            #set ($photo_credit_link = $i.PhotoCreditLink.data)
                            #if($photo_credit_link.matches("^(http|https)://.*"))
                                <a href="$photo_credit_link">$photo_credit_text</a>
                            #else
                                <a href="http://$photo_credit_link">$photo_credit_text</a>
                            #end
                        #else
                            $photo_credit_text
                        #end
                    </span>
                    </span>
                #end
</div>
</div>

            </div>
          #end
        </div>
      </div>

</div>

#foreach ( $config in $SliderConfiguration.getSiblings() )
  #set ( $transition_type = $config.transitiontype.data )
  #set ( $random = $config.randomized.data )
  #set ( $items = $config.carouselitems.data )
  #set ( $interval = $config.interval.data )
  #set ( $speed = $config.speed.data )
  #set ( $autostart = $config.autostart.data )
  #set ( $slider_title = $config.title.data )
  #set ( $custom_class = $config.customclass.data )
  #set ( $nav_type = $config.navigation.data )
  #set ( $layout_type = $config.slidelayout.data )
  #set ( $items_to_display = $config.itemstodisplay.data )
  #set ( $footer_link = $config.footerlink.data )
  #set ( $footer_link_text = $config.footerlink-text.data )
#end

#if ( ( ! $transition_type ) || ( $transition_type == "" ) )
  #set ( $transition_type = "fade" )
#end

#set ( $start_slide_opacity = 1)
#if ($transition_type == "fade")
  #set ( $start_slide_opacity = 0)
#end

#if ( ( ! $items ) || ( $items == "" ) )
  #set ( $items = 1 )
#end

#set ( $nav_type-direction = "false" )
#set ( $nav_type-dots = "false" )
#set ( $nav_type-tabs = "false" )
#set ( $slider_col_size = "span12")

#if ( $nav_type == "direction" )
  #set ( $nav_type-direction = "true" )
#elseif ( $nav_type == "dots" )
  #set ( $nav_type-dots = "true" )
#elseif ( $nav_type == "tabs" )
  #set ( $nav_type-tabs = "true" )
  #set ( $slider_col_size = "span10")
#end

#if ( ! $layout_type  || $layout_type == "" )
  #set ( $layout_type = "normal" )
#end

#if ( ! $custom_class  || $custom_class == "" )
  #set ( $custom_class = "" )
#end

#if ( !$random || $random == "" )
    #set ( $random = false )
#end

#if (! $items_to_display  || $items_to_display == "" )
  #set ( $items_to_display = 1 )
#end

#if ($items_to_display == 2)
  #set ($counter = 0)
  #set ($size = $SlideItem.getSiblings().size())
#end

<div class="slider slider-component container-fluid $slider_title.toLowerCase().replace(" ", "-") $layout_type $custom_class">
  <div class="slide-container row-fluid" data-slide-random="$random" data-slide-transition="$transition_type" data-slide-interval="$interval" data-slide-speed="$speed"  data-slide-autostart="$autostart" data-slide-navigation="$nav_type-direction" data-slide-dots="$nav_type-dots" data-slide-carousel="$items">
      <div class="slider $slider_col_size">

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

            ## Checking if image exists
            #if ( $i.Image.getData() != "" )
              #set ($image = "image")
            #else
              #set ($image = "no-image")
            #end

            ## Checking if description exists
            #if ( $i.Description.getData() != "" )
              #set ($description_text = "description")
            #else
              #set ($description_text = "no-description")
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

            ## Checking if background overlay is set
            #set ($background_overlay = $i.backgroundoverlay.data)

            #if ($items_to_display == 2)
              #set ($counter = $counter + 1)
              #if (($counter % 2) != 0 || $counter == 1)
                #if ( $i.Description.getData() != "" && $i.Image.getData() != "" && $layout_type != "profile" )
                  <div class="slide slide-double $text_color $title_text_color $title_border_color $image $description_text" id="$reserved-article-id.getData()carouselitem$velocityCount" style="background-image: url($i.Image.getData());">
                #else
                  <div class="slide slide-double $text_color $title_text_color $title_border_color $image $description_text" id="$reserved-article-id.getData()carouselitem$velocityCount">
                #end
              #else
              #end


              #if (($counter % 2) != 0 || $counter == 1)
                <div class="slide-inner width-50 slide-left">
              #else
                <div class="slide-inner width-50 slide-right">
              #end

              #if ( $i.Description.getData() != "" && $i.Image.getData() != "" && $layout_type != "profile" )
              #else
                <img src="$i.Image.getData()" />
              #end
              #if ( $slider_title.toLowerCase().replace(" ", "-") == "featuring" )
                <div class="slide-description span7">
              #else
                <div class="slide-description">
              #end
              #if ( $i.Title.getData() != "" )
                <h3>$i.Title.getData()</h3>
              #end
              $i.Description.getData()
                </div>
              </div>
              #if (($counter % 2) == 0 || ($counter == $size))
                </div>
              #else
              #end
            #else
              #if ( $i.Description.getData() != "" && $i.Image.getData() != "" && $layout_type != "profile" )
                <div class="slide $text_color $title_text_color $title_border_color $image $description_text" id="$reserved-article-id.getData()carouselitem$velocityCount" style="background-image: url($i.Image.getData());">
                #if ($background_overlay != "")
                    <div class="mobile-fade" style="background-color: $background_overlay"></div>
                #end
              #else
                <div class="slide $text_color $title_text_color $title_border_color $image $description_text" id="$reserved-article-id.getData()carouselitem$velocityCount">
                #if ( $i.Image.getData() != "" )
                  <img src="$i.Image.getData()" />
                #end
              #end

              #if ( $slider_title.toLowerCase().replace(" ", "-") == "featuring" )
                  <div class="slide-description span7">
              #else
                  <div class="slide-description">
              #end
                  #if ( $i.Title.getData() != "" )
                    <h3>$i.Title.getData()</h3>
                  #end
                  $i.Description.getData()
                </div>

              #if ( $i.PhotoCreditText.getData() != "" )

                <span class="photo-credit">
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

              #end


              </div>
            #end
          #end
        </div>
      </div>
#if ($footer_link and $footer_link_text)
<a href="$footer_link" class="view-all-x-updates-link">$footer_link_text</a>
#end
    #if ( $nav_type-tabs == "true" )
      <ol class="items slide-tabs span2 pull-right">
        #foreach($i in $SlideItem.getSiblings())
          <li instance="$reserved-article-id.getData()"><h3>$i.Title.getData()</h3></li>
        #end
      </ol>
    #end
  </div>
</div>

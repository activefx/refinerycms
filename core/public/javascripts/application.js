// Place your application-specific JavaScript functions and classes here

$(document).ready(function(){
  // Add rounded corners to main content
  $('#body_content').corner('5px');
  // Focus on the first form element
  $('form').focus_first();
  // Add support for javascript flash messages
  init_flash_messages();
  // Add tooltip support
  init_tooltips();
});

// Focus first element
$.fn.focus_first = function() {
  var elem = $('input:visible', this).get(0);
  var select = $('select:visible', this).get(0);
  if (select && elem) {
    if (select.offsetTop < elem.offsetTop) {
      elem = select;
    }
  }
  var textarea = $('textarea:visible', this).get(0);
  if (textarea && elem) {
    if (textarea.offsetTop < elem.offsetTop) {
      elem = textarea;
    }
  }

  if (elem) {
    elem.focus();
  }
  return this;
}

init_flash_messages = function(){
  $('#flash').css({
    'opacity': 0
    , 'visibility':'visible'
  }).animate({'opacity': '1'}, 550);
  $('#flash_close').click(function(e) {
     $('#flash').animate({'opacity': 0, 'visibility': 'toggle'}, 330);
     e.preventDefault();
  });
  $('#flash.flash_message').prependTo('#body_content_left');
};

init_tooltips = function(args){
  $($(args != null ? args : 'a[title], span[title], #image_grid img[title], *[tooltip]')).not('.no-tooltip').each(function(index, element)
  {
    // create tooltip on hover and destroy it on hoveroff.
    $(element).hover(function(e) {
      if (e.type == 'mouseenter' || e.type == 'mouseover') {
        $(this).oneTime(350, 'tooltip', $.proxy(function() {
          $('.tooltip').remove();
          tooltip = $("<div class='tooltip'><div><span></span></div></div>").appendTo('#tooltip_container');
          tooltip.find("span").html($(this).attr('tooltip'));
          if(!$.browser.msie) {
            tooltip.corner('6px').find('span').corner('6px');
          }

          tooltip_nib_image = $.browser.msie ? 'tooltip-nib.gif' : 'tooltip-nib.png';
          nib = $("<img src='/images/refinery/"+tooltip_nib_image+"' class='tooltip-nib'/>").appendTo('#tooltip_container');

          tooltip.css({
            'opacity': 0
            , 'maxWidth': '300px'
          });
          required_left_offset = $(this).offset().left - (tooltip.outerWidth() / 2) + ($(this).outerWidth() / 2);
          tooltip.css('left', (required_left_offset > 0 ? required_left_offset : 0));

          var tooltip_offset = tooltip.offset();
          var tooltip_outer_width = tooltip.outerWidth();
          if (tooltip_offset && (tooltip_offset.left + tooltip_outer_width) > (window_width = $(window).width())) {
            tooltip.css('left', window_width - tooltip_outer_width);
          }

          tooltip.css({
            'top': $(this).offset().top - tooltip.outerHeight() - 2
          });

          nib.css({
            'opacity': 0
          });

          if (tooltip_offset = tooltip.offset()) {
            nib.css({
              'left': $(this).offset().left + ($(this).outerWidth() / 2) - 5
              , 'top': tooltip_offset.top + tooltip.height()
            });
          }

          try {
            tooltip.animate({
              top: tooltip_offset.top - 10
              , opacity: 1
            }, 200, 'swing');
            nib.animate({
              top: nib.offset().top - 10
              , opacity: 1
            }, 200);
          } catch(e) {
            tooltip.show();
            nib.show();
          }
        }, $(this)));
      } else if (e.type == 'mouseleave' || e.type == 'mouseout') {
        $(this).stopTime('tooltip');
        if ((tt_offset = (tooltip = $('.tooltip')).css('z-index', '-1').offset()) == null) {
          tt_offset = {'top':0,'left':0};
        }
        tooltip.animate({
          top: tt_offset.top - 20
          , opacity: 0
        }, 125, 'swing', function(){
          $(this).remove();
        });
        if ((nib_offset = (nib = $('.tooltip-nib')).offset()) == null) {
          nib_offset = {'top':0,'left':0};
        }
        nib.animate({
          top: nib_offset.top - 20
          , opacity: 0
        }, 125, 'swing', function(){
          $(this).remove();
        });
      }
    }).click(function(e) {
      $(this).stopTime('tooltip');
    });

    if ($(element).attr('tooltip') == null) {
      $(element).attr('tooltip', $(element).attr('title'));
    }
    // wipe clean the title on any children too.
    $elements = $(element).add($(element).children('img')).removeAttr('title');
    // if we're unlucky and in Internet Explorer then we have to say goodbye to 'alt', too.
    if ($.browser.msie){$elements.removeAttr('alt');}
  });
};


/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

(function($) {
    
    $(document).ready(function() { 
        
        $('#add_member_link').live('click',function(e){
           e.preventDefault();
           //Get the A tag
          var id = '#dialog_form_member';

          //Get the screen height and width
          var maskHeight = $(window).height();
          var maskWidth = $(window).width();
          //Set height and width to mask to fill up the whole screen
          $('#mask').css({'width':maskWidth,'height':maskHeight});

          //transition effect    
          $('#mask').fadeIn(200);   

          //Get the window height and width
          var winH = $(window).height();
          var winW = $(window).width();

          //Set the popup window to center
          $(id).css('top',  winH/2-$(id).height()/2);
          $(id).css('left', winW/2-$(id).width()/2);

          //transition effect
          $(id).fadeIn(2000);
        });
    });
    
    
    
})(jQuery);
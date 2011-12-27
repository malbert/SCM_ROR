/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


(function($) {
    
    var flag = false;
   
    $(document).ready(function() {
        
        $('.add_button').live('click', function(e){
            e.preventDefault();
            var $url = $(this).attr('href');
            if (!($url.indexOf('?') > 0)){
                //$url += '?';
            }
            console.log($url);
            $.ajax({ 
                url: $url, 
                cache: false, 
                dataType : 'json',
                complete:function(data){ 
                    console.log(data);
                  $('#grade_create').html(data.responseText);
                  var id = '#dialog_form_grade';

                  //Get the screen height and width
                  var maskHeight = $(window).height()  * 2;
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
                  $(id).fadeIn(200);

                },
                error:function(XMLHttpRequest, textStatus, errorThrows){ // erreur durant la requete
                }
            });
        });
    });
    
})(jQuery);
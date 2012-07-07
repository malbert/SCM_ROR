/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function inputSupportsType(test){
    var input = document.createElement('input');
    input.setAttribute('type', test);
    if (input.type == 'text'){
        return false;
    } else {
        return true;
    }
}

function getKeys(arr){
  var keys = [];
  for(var i in arr) {
    if (arr.hasOwnProperty(i)){
        keys.push(i);
    }
  }
  return keys;
}


(function($) {
    
    var flag = false;
   
    
    $(document).ready(function() { 
        
        //Superfish menu initialization
        //$('ul.sf-menu').superfish(); 
        
        //$("#club_description").markItUp(mySettings);
        //$("#club_schedule").markItUp(mySettings);
        //$("#club_accessibility").markItUp(mySettings);
        //$("#club_contact").markItUp(mySettings);
    
      var $userMenuButton = $('#display_user_menu');
      var isUserMenuDisplayed = false;
      
      $userMenuButton.live('click',function(e){
        e.preventDefault();
        var $im = $("#user_menu_button");
        var $menulist = $('#user_menu_list');
        $menulist.toggle(200);
        
        var offset = $(this).offset();
        $menulist.offset({ top: offset.top + 34, left: offset.left });
        
        if (isUserMenuDisplayed){
          $im.attr("src", "/images/usermenu/button_params.png");
          isUserMenuDisplayed = false;
          
        }else {
          $im.attr("src", "/images/usermenu/button_params_hover.png");
          isUserMenuDisplayed = true;
        }
      });


      //select all the a tag with name equal to modal
      $('a#signin').live('click', function(e) {
          //Cancel the link behavior
          e.preventDefault();
          //Get the A tag
          var id = '#dialog';

          //Get the screen height and width
          var maskHeight = $(window).height();
          var maskWidth = $(window).width();
          //Set height and width to mask to fill up the whole screen
          $('#mask').css({'width':maskWidth,'height':maskHeight});

          //transition effect    
          $('#mask').fadeIn(500);   

          //Get the window height and width
          var winH = $(window).height();
          var winW = $(window).width();

          //Set the popup window to center
          $(id).css('top',  winH/2-$(id).height()/2);
          $(id).css('left', winW/2-$(id).width()/2);

          //transition effect
          $(id).fadeIn(2000);

      });
      
      if (inputSupportsType('search')){
          var $lists = $('input[type="search"]');
          $('input[type="search"]').each(function(){
             $(this).css('border-radius', '8px');
             $(this).css('-moz-order-radius', '8px');
             $(this).css('border', '1px inset white');
             $(this).css('height', '1.6em');
             $(this).css('padding-left', '1em');
             
             $(this).parent().css('width', '55%');
          });
      }

      //if close button is clicked
      $('.window .close').live('click', function (e) {
          //Cancel the link behavior
          e.preventDefault();
          $('#mask, .window').hide();
      });    
      

      //if mask is clicked
      $('#mask').live('click', function () {
          $(this).hide();
          $('.window').hide();
      });    
      
      //select all the a tag with name equal to modal
      $('a#signin').click(function(e) {
          //Cancel the link behavior
          e.preventDefault();
          //Get the A tag
          var id = '#dialog';

          //Get the screen height and width
          var maskHeight = $(window).height();
          var maskWidth = $(window).width();
          //Set height and width to mask to fill up the whole screen
          $('#mask').css({'width':maskWidth,'height':maskHeight});

          //transition effect    
          $('#mask').fadeIn(500);   

          //Get the window height and width
          var winH = $(window).height();
          var winW = $(window).width();

          //Set the popup window to center
          $(id).css('top',  winH/2-$(id).height()/2);
          $(id).css('left', winW/2-$(id).width()/2);

          //transition effect
          //$(id).fadeIn(2000);
          $(id).show();

      });

      //if close button is clicked
      $('.window .close').click(function (e) {
          //Cancel the link behavior
          e.preventDefault();
          $('#mask, .window').hide();
      });    
      

      //if mask is clicked
      $('#mask').click(function () {
          $(this).hide();
          $('.window').hide();
      });     
      
      $('#new_user_session input[name="user_session[email]"], #new_user_session input[name="user_session[password]"]').live('change', function(){
          $('#loggin-error').hide();
          $('#dialog').css("height", "260px");
      });
      
      $('#user_session_submit').live('click', function(e){
          e.preventDefault();
          
          if (!flag){
              flag = true;
              $('#loggin-error').hide();
              $('#dialog').css("height", "260px");
              var $url =  $('#new_user_session').attr('action');
              
              var $utf8 = $('input[name="utf8"]').val();
              var $authenticity_token = $('input[name="authenticity_token"]').val();
              
              var $username_or_email = $('input[name="user_session[email]"]').val();
              var $password = $('input[name="user_session[password]"]').val();
              var $rememberme = $('input[name="user_session[remember_me]"]').val();
              console.log($username_or_email + ' - ' + $password + ' - ' + $rememberme);
              
              $.ajax({
                    url: $url,
                    data: {"utf8": $utf8, "authenticity_token" : $authenticity_token, "user_session[email]" : $username_or_email, "user_session[password]" : $password, "user_session[remember_me]" : $rememberme},
                    type : "POST",
                    async : true,
                    dataType : "json",
                    error : function(jqXHR, textStatus, errorThrown){
                        console.log("ajax : " + textStatus);

                        console.log("Error request status text: " + jqXHR.statusText);
                        console.log("Error request status: " + jqXHR.status);
                        console.log("Error request response text: " + jqXHR.responseText);
                        console.log("Error response header: " + jqXHR.getAllResponseHeaders());
                        flag = false;

                    },
                    success: function(data){
                       
                        console.log(data);
                        if (data.status == 'error'){
                          $('#loggin-error').toggle();
                          $('#dialog').css("height", "300px");
                        }else {
                          //the user is logged
                          window.location = data.forward;
                        }
                        
                        flag = false;
                    }
                });
          }
      });
      
      $('table tr[id^="club_"]').live('click', function(e){
          var $id = $(this).attr('id');
          var pos = $id.indexOf('_');
          var club_id  = $id.substr(pos +1);
          console.log(club_id);
          
      });
      
      
      
  });
  
})(jQuery);


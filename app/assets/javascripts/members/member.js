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
            
            $('#new_membergrade')
              .live("ajax:beforeSend", function(evt, xhr, settings){
                var $submitButton = $(this).find('input[name="commit"]');
                //check form completion
                 var check = true;
                 var $grade = $('#membergrade_grade_id option:selected').val();
                 var $date1 = $('#membergrade_since_date_1i option:selected').val();
                 var $date2 = $('#membergrade_since_date_2i option:selected').val();
                 var $date3 = $('#membergrade_since_date_3i option:selected').val();

                 var check = true;
                 if ($grade == ''){
                   check = false;
                   $('#membergrade_grade_id').addClass('error');
                 } else {
                     $('#membergrade_grade_id').removeClass('error');
                 }
                 
                 if ($date1 == ''){
                   check = false;
                   $('#membergrade_since_date_1i').addClass('error');
                 } else {
                     $('#membergrade_since_date_1i').removeClass('error');
                 }
                 
                 if ($date2 == ''){
                   check = false;
                   $('#membergrade_since_date_2i').addClass('error');
                 } else {
                    $('#membergrade_since_date_2i').removeClass('error'); 
                 }
                 
                 if ($date3 == ''){
                   check = false;
                   $('#membergrade_since_date_3i').addClass('error');
                 } else {
                   $('#membergrade_since_date_3i').removeClass('error');  
                 }
                 
                 if (!check){
                   return false;
                 }
                 else {
                  // Update the text of the submit button to let the user know stuff is happening.
                  // But first, store the original text of the submit button, so it can be restored when the request is finished.
                  $(this).find("div.ajax-loader-wrapper").removeClass('hidden');
                 }

              })
              .live("ajax:success", function(evt, data, status, xhr){
                //never called
                var $form = $(this);

                // Reset fields and any validation errors, so form can be used again, but leave hidden_field values intact.
                $form.find('textarea,input').val("");
                $form.find('select').val('');
                $form.find('div.member_error').empty();

                // Insert response partial into page below the form.
                //$('#comments').append(xhr.responseText);


              })
              .live('ajax:complete', function(evt, xhr, status){
                var $submitButton = $(this).find('input[name="commit"]');

                // Restore the original submit button text
                $submitButton.text( $(this).data('origText') );
                $(this).find("div.ajax-loader-wrapper").addClass('hidden');
                $('#dialog_form_grade').fadeOut(200);
                $('#mask').fadeOut(200); 

                var $form = $(this);
                var $artid = $('#new_membergrade input[name="membergrade[art_id]"]').val();
                var html_table_id = "#art_table_" + $artid;
                var $html_elem = $(html_table_id);
                $html_elem.html(xhr.responseText);
                
                // Reset fields and any validation errors, so form can be used again, but leave hidden_field values intact.
                $form.find('textarea,input[type="text"],input[type="file"]').val("");
                $form.find('div.validation-error').empty();
              })
              .live("ajax:error", function(evt, xhr, status, error){
                var $form = $(this),
                    errors,
                    errorText;

                try {
                  // Populate errorText with the comment errors
                  errors = $.parseJSON(xhr.responseText);
                } catch(err) {
                  // If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
                  errors = {message: "Please reload the page and try again"};
                }

                // Build an unordered list from the list of errors
                errorText = "There were errors with the submission: \n<ul>";

                for ( error in errors ) {
                  errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
                }

                errorText += "</ul>";

                // Insert error list into form
                $form.find('div.validation-error').html(errorText);
              });
        });
    });
    
})(jQuery);
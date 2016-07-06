$(document).ready(function(){
  var $password_field = $("input[name='user[password]']");
  var $password_confirmation_field = $("input[name='user[password_confirmation]']");
  var $email_field = $("input[name='user[email]']");
  var $username_field = $("input[name='user[username]']");

  var $inputs = $("#new_user input");
  $("#btn-signup").prop("disabled", true);  

  $email_field.on("keyup", function(){
    $("#btn-signup").prop('disabled', this.value == "" ? true : false);  
  });    

  $username_field.on("keyup", function(){
    $("#btn-signup").prop('disabled', this.value == "" ? true : false);  
  });    


  $password_field.on("keyup", function(){

    if ($(this).val().length >= 8 ) {
      $(this).addClass("field-success").removeClass("field-error");
    } else {
      $(this).addClass("field-error").removeClass("field-success");
    }

  });

  $password_confirmation_field.on("keyup", function(){
    if ($password_field.val().length > 0) {

      if ($(this).val() == $password_field.val() ) {
        $(this).addClass("field-success").removeClass("field-error");
      } else {
        $(this).addClass("field-error").removeClass("field-success");
      }

    }
  });

  $inputs.on("keyup", function(){
    $.each( [ $inputs ], function( i, l ){
    
      if ($(l).hasClass("field-error")) {
        $("#btn-signup").attr("disabled", true);      
      } else {
        $("#btn-signup").attr("disabled", false);      
      }

    });
  });


});
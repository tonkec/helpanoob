$(document).ready(function(){
  var $password_field = $("input[name='user[password]']");
  var $password_confirmation_field = $("input[name='user[password_confirmation]']");
  var $email_field = $("input[name='user[email]']");
  var $username_field = $("input[name='user[username]']");

  var $form = $("#new_user");

  $("#btn-signup").click(function(e){

    if ($("#new_user input").hasClass("field-error")) {
      e.preventDefault();
      $(".homepage-error-message").remove();
      $("#new_user").prepend("<h5 class='homepage-error-message'>Please fix the errors!</h5>");
    } else {
      $(".homepage-error-message").remove();
      $(this).unbind('submit').submit();
    }

  });
});
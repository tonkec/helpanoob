//= require underscore-min

$(function() {
  var $email_field = $("input[name='user[email]']");
  var $username_field = $("input[name='user[username]']");
  var email_endpoint = $email_field.attr("data-endpoint");
  var username_endpoint = $username_field.attr("data-endpoint");
  var emailRegex = /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/;

  $email_field.on("keyup", _.debounce(checkEmailUniqueness, 500));
  $username_field.on("keyup", _.debounce(checkUserNameUniqueness, 500));

  function checkEmailUniqueness() {
    var email = $email_field.val();

    if (emailRegex.test(email)) {
      $.get(email_endpoint, { email: email }, function(data) {
        handleSuccess(data, $email_field);
      });
    } else {
      removeStatus($email_field);
    }
  }

  function checkUserNameUniqueness() {
    var username = $username_field.val();

    if (username.length > 0) {
      $.get(username_endpoint, { username: username }, function(data) {
        handleSuccess(data, $username_field);
      });
    } else {
      removeStatus($username_field);
    }
  }

  function handleSuccess(data, $field) {
    if (data["availability"] == "available") {
      setAvailable($field);
    } else if (data["availability"] == "taken")  {
      setError($field);
    }
  }

  function setAvailable($field) {
    removeStatus($field);
    $field.addClass("email-success");
  }

  function setError($field) {
    removeStatus($field);
    $field.addClass("email-error");
  }

  function removeStatus($field) {
    $field.removeClass("email-error email-success");
  }
});

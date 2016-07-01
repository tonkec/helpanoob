//= require underscore-min

$(function() {
  var $field = $("input[name='user[email]']");
  var endpoint = $field.attr("data-endpoint");
  var emailRegex = /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/;

  $field.on("keyup", _.debounce(checkEmailUniqueness, 500));

  function checkEmailUniqueness() {
    email = $field.val();

    if (emailRegex.test(email)) {
      $.get(endpoint, { email: email}, handleSuccess);
    }
  }

  function handleSuccess(data) {
    if (data["availability"] == "available") {
      setAvailable();
    } else if (data["availability"] == "taken")  {
      setError();
    }
  }

  function setAvailable() {
    removeStatus();
    $field.addClass("email-success");
  }

  function setError() {
    removeStatus();
    $field.addClass("email-error");
  }

  function removeStatus() {
    $field.removeClass("email-error email-success");
  }
});

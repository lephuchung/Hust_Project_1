function togglePassword() {
    var passwordField = document.getElementById("password");
    var showPasswordCheckbox = document.getElementById("showPassword");

    if (showPasswordCheckbox.checked) {
      passwordField.type = "text";
    } else {
      passwordField.type = "password";
    }
}

function toggleRePassword() {
    var rePasswordField = document.getElementById("re-password");
    var showRePasswordCheckbox = document.getElementById("showRePassword");

    if (showRePasswordCheckbox.checked) {
        rePasswordField.type = "text";
    } else {
        rePasswordField.type = "password";
    }
  }
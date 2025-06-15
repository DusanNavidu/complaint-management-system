$(document).ready(function() {
    $("#signInForm").on("submit", function(e) {
        $("#usernameError").text('');
        $("#passwordError").text('');
        $("#serverError").text('');
        $("#username").removeClass("invalid");
        $("#password").removeClass("invalid");

        let isValid = true;

        let username = $("#username").val();
        // Match backend: only a-z, A-Z, 0-9, and _ (3–20 chars)
        if (!/^[A-Za-z0-9_]{3,20}$/.test(username)) {
            $("#usernameError").text('Invalid User Name (3-20 characters: letters, digits, or underscore)');
            $("#username").addClass("invalid");
            isValid = false;
        }

        let password = $("#password").val();
        // Match backend: only digits, length 6–10
        if (!/^\d{6,10}$/.test(password)) {
            $("#passwordError").text('Password must be 6–10 digits only');
            $("#password").addClass("invalid");
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault();
        }
    });
});

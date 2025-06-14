document.getElementById('signupForm').addEventListener('submit', function (e) {
    const password = document.getElementById('password').value.trim();
    const confirmPassword = document.getElementById('confirm_password').value.trim();

    if (password !== confirmPassword) {
        e.preventDefault();
        alert("Passwords do not match!");
    }
});
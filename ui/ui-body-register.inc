<?php
echo '<div class="container d-flex flex-column justify-content-center align-items-center mt-auto">
<h4>Register</h4>
<p>Use your work email and password to login</p>
<form action="login.php" method="POST">
<div class="mb-3">
<label for="userEmail" class="form-label">Email Address</label>
<input type="email" class="form-control" id="userEmail">
</div>
<div class="mb-3">
<label for="userPassword" class="form-label">Password</label>
<input type="password" class="form-control" id="userPassword">
</div>
<div class="mb-3">
<label for="verifyPassword" class="form-label">Verify Password</label>
<input type="password" class="form-control" id="verifyPassword">
</div>
<button type="submit" class="btn btn-primary btn-lg">Register</button>
</form>
</div>';
?>

<?php
echo '<div class="container d-flex flex-column justify-content-center align-items-center mt-auto">
<h4>Log in</h4>
<p>Use your work email and password to login</p>
<form action="core/core-db-login.php" method="POST">
<div class="mb-3">
<label for="userEmail" class="form-label">Email Address</label>
<input type="email" class="form-control" id="usrEmail">
</div>
<div class="mb-3">
<label for="userPassword" class="form-label">Password</label>
<input type="password" class="form-control" id="usrPassword">
</div>
<button type="submit" class="btn btn-primary btn-lg">Login</button>
</form>
</div>';
?>
<?php
echo '<form action="register.php" method="POST">
<div class="mb-3">
<label for="userEmail" class="form-label">Email Address</label>
<input type="email" class="form-control" id="userEmail">
</div>
</div>
<div class="mb-3">
<label for="userPassword" class="form-label">Password</label>
<input type="password" class="form-control" id="userPassword">
</div>
<div class="mb-3">
<label for="confirmPassword" class="form-label">Confirm Password</label>
<input type="password" class="form-control" id="confirmPassword">
</div>
<button type="submit" class="btn btn-primary">Register</button>
</form>';
?>

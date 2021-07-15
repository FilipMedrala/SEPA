<?php
echo '<div class="container">
<h2 class="text-center">Fuzzing Subsystem</h2>
<p>This portal will allow you to fuzz your pre-release binaries to detect potential code bugs. The fuzzing functionality is provided with American Fuzzy Lop (AFL).</p>';
include 'ui/ui-fuzz-alert-intro.inc';
echo '<h3>Binary File Upload</h3>';
echo '<div class="mb-3">
<form action="core/core-up-binary.php" method="post" enctype="multipart/form-data">
<label for="upFile" class="form-label">Select binary for AFL upload:</label>
<input name="usrFile" type="file" class="form-control" id="upFile" onchange="document.getElementById("fuzzFile").value = this.value;">
<button type="submit" class="btn btn-primary" id="upSubmit">Upload</button>
</form>
</div>';
echo '<h3>Fuzzing Results</h3>';
echo '<div class="mb-3">
<form action="core/core-up-handover.php" method="post">
<label for="fuzzFile" class="form-label">Select binary for AFL fuzzing:</label>
<input name="startFile" type="text" class="form-control" id="fuzzFile" value="">
<button type="submit" class="btn btn-primary" id="fuzzSubmit">Start Fuzzing</button>
</form>
</div>';
echo '<h4>Server console output:</h4>';
echo '<p>Place frame with piped fuzzing progress & JS progressbar here</p>';
include 'ui/ui-fuzz-alert-success.inc';
include 'ui/ui-fuzz-alert-failure.inc';
?>

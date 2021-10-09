<html>
<body>
<?php
Application name: echo $_POST["appname"]; <br>

## Get Parameters
$P1 = ($_POST['userid']);
$P2 = ($_POST['jobid']);
$P3 = ($_POST['appname']);
$P4 = ($_POST['jobtype']);
$P5 = ($_POST['fastcalc']);
$P6 = ($_POST['statsd']);

echo "<p>$P1 $P2 $P3 $P4 $P5 $P6</p>"




?>
</body>
</html>

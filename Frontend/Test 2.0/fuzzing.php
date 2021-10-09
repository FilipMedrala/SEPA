<html>
<body>
<?php
Application name: echo $_POST["appname"]; <br>

## Get Parameters
$P1 = ($_POST['userid']);
$P2 = ($_POST['jobid']);
$P3 = ($_POST['jobtype']);
if (isset($_POST['param1'])) {
  $P4 = ($_POST['param1'])
};
if (isset($_POST['param2'])) {
  $P4 .= ($_POST['param2'])
};
if (isset($_POST['param3'])) {
  $P4 .= ($_POST['param3'])
};
if (isset($_POST['param4'])) {
  $P4 .= ($_POST['param4'])
};
if (isset($_POST['param5'])) {
  $P4 .= ($_POST['param5'])
};




?>
</body>
</html>

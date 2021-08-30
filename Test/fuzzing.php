<?php require 'config/cfg-ip-acl.req';?>
<?php require 'config/cfg-ssl.req';?>
<?php session_start();
$_SESSION["usrId"] = "test1234";
$_SESSION["jobId"] = "1234";
?>
<!DOCTYPE html>
<html>
<?php include 'ui/ui-header-index.inc';?>
<?php include 'ui/ui-nav-static.inc';?>

<body>
<?php include 'ui/ui-jumbotron-fuzz.inc';?>
<?php include 'ui/ui-body-fuzz.inc';?>
<?php include 'ui/ui-footer.inc';?>
</body>
</html>

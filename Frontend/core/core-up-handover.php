<?php
## binary upload handler for fuzzing files
## Exit to main page if accessed by any other means except the html form
#if (!isset($_POST["fuzzFile"]))
#{
#  header("location: fuzzing.php");
#  exit();
#}
session_start();
## Sanitise filename input just in case
function sanitise_input($data)
{
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
$uploaded_file = sanitise_input($uploaded_file);
## Prepared AFL++ commands
$afl_qemu_mode = 'afl-fuzz -Q -i /var/www/html/usr/' . $_SESSION["usrId"] . '/' . $_SESSION["jobId"] . '/afl_in -o /var/www/html/usr/' . $_SESSION["usrId"] . '/' . $_SESSION["jobId"] . '/afl_out /var/www/html/usr/' . $_SESSION["usrId"] . '/' . $_SESSION["jobId"] . '/' . $uploaded_file;
$afl_unicorn_mode = 'afl-fuzz -U -i /var/www/html/usr/$_SESSION["usrId"]/$_SESSION["jobId"]/afl_in -o /var/www/html/usr/$_SESSION["usrId"]/$_SESSION["jobId"]/afl_out /var/www/html/usr/$_SESSION["usrId"]/$_SESSION["jobId"]/$uploaded_file';
## Select AFL Mode based on user submission

## Debug - Print full AFL++ command
echo "<p>$afl_qemu_mode</p>";
echo "<p>$afl_unicorn_mode</p>";
## Execute AFL++ Fuzzing Script in Unic mode

?>

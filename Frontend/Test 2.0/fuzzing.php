<html>
<head>
  <link href="vendor/bootstrap-v5/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
<?php
#echo "Application name: " . ($_POST['appname']);

### Input Sanitisation
## Most inputs are predefined however perform this anyway...
function sanitise_input($data)
{
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}
## Sanitise to legal string
function sanitise_input_l2($data)
{
  $data = sanitise_input($data);
  $data = filter_var($data, FILTER_SANITIZE_STRING);
  return $data;
}
## Sanitise to legal integer
function sanitise_input_l3($data)
{
  $data = sanitise_input($data);
  $data = filter_var($data, FILTER_SANITIZE_NUMBER_INT);
  return $data;
}

### Job ID Generation
## Generate pseudo-random integer, we use 16 for length default
function gen_random_id($length) {
    $result = '';
    for($i = 0; $i < $length; $i++) {
        $result .= random_int(9, 19);
    }
    return $result;
}
function gen_random_id_alt() {
  $result = random_int(000000000000, 999999999999);
  return $result;
}

### Get Parameters
## leave uuid untouched, format included hyphen & digits, Will be fixed later
## Grab P1 & P2 from different sources non-POST
## Raw Variable Block
#$P1 = ($_POST['userid']);
$P1 = ($_COOKIE['userID']);
$P2 = gen_random_id_alt();
$P3 = ($_POST['appname']);
$P4 = ($_POST['jobtype']);
$P5 = ($_POST['fastcal']);
$P6 = ($_POST['statsd']);
$P7 = ($_POST['compiler']);
## Sanitised Variable Block
$P1san = $P1;
$P2san = sanitise_input_l3($P2);
$P3san = sanitise_input_l2($P3);
$P4san = sanitise_input_l3($P4);
$P5san = sanitise_input_l3($P5);
$P6san = sanitise_input_l2($P6);
$P7san = sanitise_input_l2($P7);

### Debug Paramter
## View raw POST values in sent array
#echo "<p>Variables dump: $P1san, $P2san, $P3san, $P4san, $P5san, $P6san, $P7san</p>";
echo '<hr>
<div class="alert alert-info" role="alert">
<h4 class="alert-heading">Variables Dump</h4>';
echo "<p>UUID: $P1san, JID: $P2san, APPNAME: $P3san, JOBTYPE: $P4san, FASTCAL: $P5san, STATSD: $P6san, COMPILER: $P7san</p>
</div>";
$svr_exec_is_ok = 0;
$tmpout = '';

### Upload File Parameters
## Set temporary destination directory
$upload_dir = "/var/www/html/aflfuzzerweb/uploadtmp/";
$upload_file1 = $upload_dir . basename($_FILES["chooseFile"]["name"]);
$upload_file2 = $upload_dir . basename($_FILES["chooseFile2"]["name"]);
## Move uploaded files in field 1 to the temporary destination directory
if (move_uploaded_file($_FILES["chooseFile"]["tmp_name"], $upload_file1)) {
  $upload1_is_ok = 1;
  $filename1=$_FILES['chooseFile']['name'];
#  echo 'your filename is: ' . $filename;
#  echo '<p>First binary uploaded successfully!</p>';
}
else {
  $upload1_is_ok = 0;
  $filename1=$_FILES['chooseFile']['name'];
#  echo 'your first filename is: ' . $filename;
#  echo '<p>First binary not uploaded successfully, please check logs!</p>';
}
## Move uploaded files in field 2 to the temporary destination directory
if (move_uploaded_file($_FILES["chooseFile2"]["tmp_name"], $upload_file2)) {
  ## Set file2 upload status to "successful"
  $upload2_is_ok = 1;
  $filename2=$_FILES['chooseFile2']['name'];
#  echo 'your second filename is: ' . $filename;
#  echo '<p>Second binary uploaded successfully!</p>';
}
else {
  ## Set file2 upload status to "failed"
  $upload2_is_ok = 0;
  $filename2=$_FILES['chooseFile2']['name'];
#  echo 'your second filename is: ' . $filename;
#  echo '<p>Second binary not uploaded successfully, please check logs!</p>';
}


### Main Code Execution Block
## Only start the AFL job via shell script if both .zip files have uploaded successfully
if ($upload1_is_ok === 1 && $upload2_is_ok === 1) {
  ## Start fuzzing job via exec pointed to the bootstrapper script
#  exec("/bin/bash /home/sepadmin/Documents/AFLscripts/startTheJobs.sh $P1san $P2san $P3san $P4san $P5san $P6san $P7san $filename1 $filename2", );
  ## Execute this script as another user to bypass some bash commands not working under www-data
  exec("sudo su - sepadmin -c /home/sepadmin/Documents/afl/scripts/startTheJobs.sh $P1san $P2san $P3san $P4san $P5san $P6san $P7san $filename1 $filename2", $tmpout, $svr_exec_is_ok);
  echo '<hr>
  <div class="alert alert-success" role="alert">
  <h4 class="alert-heading">Upload Successful!</h4>
  <p>Your files were uploaded successfully and have been sent to further backend systems to start the job!</p>
  <hr>
  ';
  echo "<h5>Debug:</h5>
  <p>value 0 indicates failure, value 1 indicates success</p>
  <p>FILE_1_UPLOAD_IS_OK: $upload1_is_ok</p>
  <p>FILE_2_UPLOAD_IS_OK: $upload2_is_ok</p>
  <p>SVR_TASK_EXEC_IS_OK: $svr_exec_is_ok</p>
  </div>
  ";
}
else {
  ## Display failure message
  #echo "Failed to start the requested AFL job: $P2, as one or both of the file uploads weren't successful.";
  ## Display failure message alternate version (Bootstrap Modal)
  echo '<hr>
  <div class="alert alert-danger" role="alert">
  <h4 class="alert-heading">Upload Error!</h4>
  <p>Failed to start the requested AFL job as one or both of the file uploads weren\'t successful.</p>
  <hr>
  ';
  echo "<h5>Debug:</h5>
  <p>value 0 indicates failure, value 1 indicates success</p>
  <p>FILE_1_UPLOAD_IS_OK: $upload1_is_ok</p>
  <p>FILE_2_UPLOAD_IS_OK: $upload2_is_ok</p>
  <p>SVR_TASK_EXEC_IS_OK: $svr_exec_is_ok</p>
  </div>
  ";
}
?>
</div>
<script src="vendor/bootstrap-v5/js/bootstrap.bundle.min.js"></script>
</body>
</html>

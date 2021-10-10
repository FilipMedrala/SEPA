<?php
#echo "Application name: " . ($_POST['appname']);

## Get Parameters
$P1 = ($_POST['userid']);
$P2 = ($_POST['jobid']);
$P3 = ($_POST['appname']);
$P4 = ($_POST['jobtype']);
$P5 = ($_POST['fastcal']);
$P6 = ($_POST['statsd']);
$P7 = ($_POST['compiler']);

#echo "<p>Variables dump: $P1, $P2, $P3, $P4, $P5, $P6, $P7</p>";

$upload_dir = "/var/www/html/aflfuzzerweb/files/uploadtmp/";
$upload_file1 = $upload_dir . basename($_FILES["chooseFile"]["name"]);
$upload_file2 = $upload_dir . basename($_FILES["chooseFile2"]["name"]);

if (move_uploaded_file($_FILES["chooseFile"]["tmp_name"], $upload_file1)) {
  $upload_is_ok = 1;
  $filename1=$_FILES['chooseFile']['name'];
#  echo 'your filename is: ' . $filename;
#  echo '<p>First binary uploaded successfully!</p>';
#  echo 'website should work';
  exec(/bin/bash /home/sepadmin/Documents/AFLscripts/startTheJobs.sh $P1 $P2 $P4 $P5 $P6 $filename1)
}
else {
  $upload_is_ok = 0;
  $filename1=$_FILES['chooseFile']['name'];
#  echo 'your first filename is: ' . $filename;
#  echo '<p>First binary not uploaded successfully, please check logs!</p>';
#  echo 'website is cooked';
}
if (move_uploaded_file($_FILES["chooseFile2"]["tmp_name"], $upload_file2)) {
  $upload_is_ok = 1;
  $filename2=$_FILES['chooseFile2']['name'];
#  echo 'your second filename is: ' . $filename;
#  echo '<p>Second binary uploaded successfully!</p>';
#  echo 'website should work';
  exec(/bin/bash /home/sepadmin/Documents/AFLscripts/startTheJobs.sh $P1 $P2 $P4 $P5 $P6 $filename2)
}
else {
  $upload_is_ok = 0;
  $filename2=$_FILES['chooseFile2']['name'];
#  echo 'your second filename is: ' . $filename;
#  echo '<p>Second binary not uploaded successfully, please check logs!</p>';
#  echo 'website is cooked';
}





?>
</body>
</html>

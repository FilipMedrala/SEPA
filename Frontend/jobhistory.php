<!DOCTYPE html>
<html class="h-100">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="Group 23">
  <link rel="icon" type="img/jpg" href="assets/images/afl.jpg">
  <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i&display=swap" rel="stylesheet">
  <title>AFL fuzzing platform - Job History</title>
  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Additional CSS Files -->
  <link rel="stylesheet" href="assets/css/fontawesome.css">
  <link rel="stylesheet" href="assets/css/style.css">
  <link rel="stylesheet" href="assets/css/owl.css">
</head>
<!-- ***** Preloader Start ***** -->
<div id="preloader">
    <div class="jumper">
        <div></div>
        <div></div>
        <div></div>
    </div>
</div>
<!-- ***** Preloader End ***** -->
<body>
<!-- Header -->
<header class="">
  <nav class="navbar navbar-expand-lg">
    <div class="container">
      <a class="navbar-brand" href="index.html"><h2>Fuzzing platform<em>.</em></h2></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto" id="list">
          <li class="nav-item" style="display:none">
            <a class="nav-link" href="login.php">Login</a>
          </li>
    <li class="nav-item">
            <a class="nav-link" href="index.html">Home
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="about.html">About Us</a>
          </li>
          <li class="nav-item active" style="display:none">
            <a class="nav-link" href="dashboard.html">Dashboard</a>
          </li>
          <li class="nav-item" style="display:none">
                <a class="nav-link" href="livemetrics.html">Live Metrics</a>
              </li>
              <li class="nav-item" style="display:none">
                <a class="nav-link" id="signOut" href="index.html">Sign out</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</header>
<!-- Banner Starts Here -->
<div class="heading-page header-text">
  <section class="page-heading">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="text-content">
            <h4>Job History</h4>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>

<div class="container">
  <br>
<h5>Previous Items Fuzzed</h5>
  <br>
<div>
  <!-- Starts the table, then the php session -->

<table class="table table-bordered table-hover shadow-sm">
<thead>
 <tr>
 <th>#</th>
   <th>Job ID</th>
   <th>Date</th>
   <th>Download</th>
   <th>Actions</th>
 </tr>
 </thead>
 <tbody>

<?php
session_start();

require_once ("settings.php");
$conn = @mysqli_connect(
$host,
$user,
$pwd,
$sql_db
);
if (!$conn) {
  echo "Mysql not connected ";
  echo mysqli_connect_errno() . ":" . mysqli_connect_error();
  exit;
}
else {
if(isset($_POST['btnStopJob'])) {
#echo ($_POST['btnStopJob']);
$pre3=($_POST['btnStopJob']);
exec("sudo su - sepadmin -c 'docker stop afl-$pre3' , , ");
exec("sudo su - sepadmin -c 'docker rm afl-$pre3' , , ");
}
$uid=($_COOKIE['userID']);
$sql = "SELECT File, Date, Adr FROM files WHERE uID='$uid'";
$query = mysqli_query($conn, $sql);
$i=1;
  while ($row=mysqli_fetch_array($query)) {
        echo '<tr>
    <th scope="row">' . $i . '</th>';
        echo '<td>' . $row['File'] . '</td>';
        echo '<td>' . $row['Date'] . '</td>';
        $folder=$row['Adr'];
	$folder2=preg_split("#/#", $folder);

        $jobdir="/home/sepadmin/Documents/afl/$folder";
        exec("sudo su - root -c '/home/sepadmin/Documents/afl/scripts/zipAflJob.sh $jobdir final compatible' , , ");
        $pre2 = "/home/sepadmin/Documents/afl/$folder/final.zip";
    	exec("sudo su - root -c 'chown sepadmin $pre2' , , ");
    	exec("sudo su - root -c 'chgrp sepadmin $pre2' , , ");
    	$pre4=$folder2[1];
        echo '<td><a href="http://localhost/aflfuzzerweb/afl/' . $folder . 'final.zip" Download> Download File </a></td>';

        $stat1=exec("sudo su - sepadmin -c 'docker ps -aqf name=afl-$pre4' , , ");
                if (empty($stat1)) {
  $stat1="NOT RUNNING";
          echo '<td>' . $stat1 . '</td>';
        echo '<td><form method="post"><button type="submit" class="btn btn-warning" id="btnStopJob" name="btnStopJob" value=' . $folder2[1] . ' disabled>Stop Job</button></form></td>';
        echo '</tr>';
        $i++;
}
else {
        echo '<td>' . $stat1 . '</td>';
        echo '<td><form method="post"><button type="submit" class="btn btn-warning" id="btnStopJob" name="btnStopJob" value=' . $folder2[1] . '>Stop Job</button></form></td>';
        echo '</tr>';
        $i++;
  }
  }
  mysqli_close($conn);
}


 ?>
</tbody>
</table>
<?php
  if(isset($_POST['btnKillAllContainers'])) {
    exec("sudo su - sepadmin -c 'docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)' , , ");
  }
  if(isset($_POST['btnKillAllNet'])) {

  }
?>
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" style="display: none" data-toggle="modal" data-target="#exampleModalCenter">Backend Commands</button>
<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Executive Orders</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<h5>Order 66</h5>
	        <p>Identifies all Docker containers as traitors to the Galactic Republic. This will terminate them with no prejudice!</p>
	         <form method="post">
	            <button type="submit" class="btn btn-danger btn-sm" id="btnKillAllContainers" name="btnKillAllContainers">Execute</button>
	         </form>
	          <hr>
	           <h5>EMP</h5>
	           <p>Terminate all active docker networks</p>
	            <form method="post">
	              <button type="submit" class="btn btn-danger btn-sm" id="btnKillAllNet" name="btnKillAllNet" disabled>Execute</button>
	            </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

</div>
</div>



<footer>
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <ul class="social-icons">
          <li><a href="#">Facebook</a></li>
          <li><a href="#">Twitter</a></li>
          <li><a href="#">Behance</a></li>
          <li><a href="#">Linkedin</a></li>
          <li><a href="#">Dribbble</a></li>
        </ul>
      </div>
      <div class="col-lg-12">
        <div class="copyright-text">
          <p>Group 23 fuzzing project</p>
        </div>
      </div>
    </div>
  </div>
</footer>



<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- JavaScript Files -->
<script src="assets/js/custom.js"></script>
<script src="assets/js/owl.js"></script>
<script src="assets/js/slick.js"></script>
<script src="assets/js/isotope.js"></script>
<script src="assets/js/accordions.js"></script>

<script language = "text/Javascript">
  cleared[0] = cleared[1] = cleared[2] = 0; //set a cleared flag for each field
  function clearField(t){                   //declaring the array outside of the
  if(! cleared[t.id]){                      // function makes it static and global
      cleared[t.id] = 1;
      t.value='';
      t.style.color= '#fff';
      }
  }
  </script>
    <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-auth.js"></script>
    <script src="assets/js/auth.js"></script>
</body>
</html>

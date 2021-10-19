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
  <link href="vendor/bootstrap-v5/css/bootstrap.min.css" rel="stylesheet">
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

<table class="table table-bordered table-hover shadow-sm">
 <tr>
   <th>Job ID</th>
   <th>Date</th>
   <th>Download</th>
 </tr>

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
$dir = $_SESSION['dir'];
$dirs = array_filter(glob('*'), 'is_dir');

$sql = "SELECT File, Date FROM files ORDER BY File";
$query = mysqli_query($conn, $sql);
$table_rows = array();
if ($query) {
  while ($row = $query -> fetch_row()) {
  //  printf ("%s (%s)\n", $row[0], $row[1]);
    $i = 0;
    $table_rows[$i]['file'] = $row[0];
    $table_rows[$i]['date'] = $row[1];
    $i++;
  }
  $count = $i;
  $query -> free_result();
}
$i = 0;
foreach($dirs as $folder)
{
     $table_rows[$i]['download'] = $folder;


    $i++;
}

for($i=0; $i < $count; $i++)
{

  ?>
            <tr>
              <td><?php echo $table_rows[$i]['file']?></td>
              <td><?php echo $table_rows[$i]['date']?></td>
              <td><?php echo  '<a href="$folder" Download> Download File </a>'?></td>

            </tr>
        <?php
}
}





 ?>

</table>
</div>
</div>

<!--
<style>
table {
  border-collapse: collapse;
  width: 90%;
  padding: 30px;
}

th, td {
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #D3D3D3;
}

 tr:hover {
  background-color: #D6EEEE;
}
</style>
-->

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
<script src="vendor/bootstrap-v5/js/bootstrap.bundle.min.js"></script>

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

<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Group 23">
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i&display=swap" rel="stylesheet">

    <title>AFL fuzzing platform - About Page</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">


    <!-- Additional CSS Files -->
    <link rel="stylesheet" href="assets/css/fontawesome.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/owl.css">
	<link rel="stylesheet" href="assets/css/upload.css">

  </head>

  <body>

    <!-- ***** Preloader Start ***** -->
    <div id="preloader">
        <div class="jumper">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
    <!-- ***** Preloader End ***** -->

    <!-- Header -->
    <header class="">
      <nav class="navbar navbar-expand-lg">
        <div class="container">
          <a class="navbar-brand" href="index.html"><h2>Fuzzing platform<em>.</em></h2></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
              <li class="nav-item">
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
              <li class="nav-item active">
                <a class="nav-link" href="dashboard.html">Dashboard</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="exit.html">Sign out</a>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </header>

    <!-- Page Content -->
    <!-- Banner Starts Here -->
    <div class="heading-page header-text">
      <section class="page-heading">
        <div class="container">
          <div class="row">
            <div class="col-lg-12">
              <div class="text-content">
                <h4>File Upload</h4>
                <h2>Choose files and parameters for testing</h2>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>

    <!-- Banner Ends Here -->


    <section class="about-us">
      <div class="container">

		 <div class="row">
			<div class="col-lg-12">
				<form action="fuzzing.php" method="post" enctype="multipart/form-data>
					<input type="text" id="userid" name="userid" placeholder="User ID"><br><br>
					<input type="text" id="jobid" name="jobid" placeholder="Job ID"><br><br>
					<input type="text" id="appname" name="appname" placeholder="Application Name"><br><br>
					<label for="jobtype">Job Type:</label><br>
					Sorce Code &nbsp <input type="radio" id="source" name="jobtype" value="1">
					&nbsp Binary &nbsp <input type="radio" id="binary" name="jobtype" value="1">
					<br><br>
					<label for="testingoptions">Testing options:</label><br>
					&nbsp Exit when done <input type="checkbox" id="testingoptions" name="testingoptions" value="exit">
					&nbsp &nbsp Timeout <input type="checkbox" id="testingoptions" name="testingoptions" value="timeout">
					&nbsp Fast Calculation <input type="checkbox" id="testingoptions" name="testingoptions" value="fastcal">
					&nbsp Autoresume <input type="checkbox" id="testingoptions" name="testingoptions" value="autoresume">
					&nbsp Debug <input type="checkbox" id="debug" name="debug" value="debug"><br><br>
					<select class="form-select mt-3" required>
                                      <option selected disabled value="">AFL_STATSD_TAGS_FLAVOR</option>
                                      <option value="dogstatsd">dogstatsd</option>
                                      <option value="librato">librato</option>
                                      <option value="signalfx">signalfx</option>
									  <option value="influxdb">influxdb</option>
                               </select><br><br>

					<div class="file-upload">
					  <div class="file-select">
						<div class="file-select-button" id="fileName">Choose Source Code or Binary File</div>
						<div class="file-select-name" id="noFile">No file chosen...</div>
						<input type="file" name="chooseFile" id="chooseFile">
					  </div>
					</div>
					<div class="file-upload">
					   <div class="file-select">
						<div class="file-select-button" id="fileName">Choose Test File (optional)</div>
						<div class="file-select-name" id="noFile">No file chosen...</div>
						<input type="file" name="chooseFile" id="chooseFile">
					  </div>
					</div><br><br>

					<input type="submit" value="Submit"/>
					<input type= "reset" value="Reset"/>
				</form>
			</div>
        </div><br><br>

        <div class="row">
          <div class="col-lg-12">
            <ul class="social-icons">
              <li><a href="#"><i class="fa fa-facebook"></i></a></li>
              <li><a href="#"><i class="fa fa-twitter"></i></a></li>
              <li><a href="#"><i class="fa fa-behance"></i></a></li>
              <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
            </ul>
          </div>
        </div>


      </div>
    </section>


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
	<script src="assets/js/upload.js"></script>

    <script language = "text/Javascript">
      cleared[0] = cleared[1] = cleared[2] = 0; //set a cleared flag for each field
      function clearField(t){                   //declaring the array outside of the
      if(! cleared[t.id]){                      // function makes it static and global
          cleared[t.id] = 1;  // you could use true and false, but that's more typing
          t.value='';         // with more chance of typos
          t.style.color='#fff';
          }
      }
    </script>
    <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.10.0/firebase-auth.js"></script>
    <script>

      var firebaseConfig = {
      apiKey: "AIzaSyDIR6Go8QoYic9psU4R_YRrfNp6e_HZQc4",
      authDomain: "test-62d52.firebaseapp.com",
      projectId: "test-62d52",
      storageBucket: "test-62d52.appspot.com",
      messagingSenderId: "790136710979",
      appId: "1:790136710979:web:1ac3789f5d8d038ca9f1f6"
    };

      firebase.initializeApp(firebaseConfig);
      var user = firebase.auth().currentUser;
    </script>

  </body>
</html>
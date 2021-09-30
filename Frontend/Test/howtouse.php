<?php require 'config/cfg-ip-acl.req';?>
<?php require 'config/cfg-ssl.req';?>
<!DOCTYPE html>
<html class="h-100">
<?php include 'ui/ui-header-index.inc';?>


<?php include 'ui/ui-nav-static.inc';?>

<!-- Banner Starts Here -->
<div class="heading-page header-text">
  <section class="page-heading">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="text-content">
            <h4>How to use</h4>
          </div>
        </div>
      </div>
    </div>
  </section>
</div>



<body class="d-flex flex-column h-100">


  <div class="container d-flex justify-content-evenly mt-auto">
  <div class = "howto">


    <p>Our AFL platform is designed for simplicity and ease of use.</p>
    <p>Simply upload your file with the click of a button.</p>

      <img src="assets/images/Howto1.png" style="width: 50%; padding: 10px" alt="">
    <p>And start Fuzzing</p>
      <img src="assets/images/Howto2.png" style="width: 50%; padding: 10px" alt="">
    <p>You can monitor your progress from the User Dashboard.</p>
    <p>Previous jobs can be found on Job History page.</p>


  </div>
  <div style="border-left: solid black">

  <div class = "vertical-center" style = "padding-left: 50px">
  <a href="fuzzing.php">
  <img src="assets/shield-shaded.svg" style="width: 90%; padding-top: 100px"  alt="...">
  </a>
  <h3>Start Fuzzing</h3>

  </div>
  </div>
</div>
<?php include 'ui/ui-footer.inc';?>











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


</body>
</html>

<?php
echo '<div class="container d-flex justify-content-evenly mt-auto">
<div>
<a href="howtouse.php">
<img src="assets/question-square-fill.svg" style="width: 100%; height: auto" class="mb-2" alt="...">
</a>
<h3>How To Use</h3>
</div>
<div>
<a href="fuzzing.php">
<img src="assets/shield-shaded.svg" style="width: 90%; height: auto" class="mb-2" alt="...">
</a>
<h3>Start Fuzzing</h3>
</div>

<div>
 <a href="jobhistory.php">
<img src="assets/clock-history.svg" style="width: 100%; height: auto" class="mb-2" alt="...">
</a>
<h3>Job History</h3>
</div>


</div>

<div>
<h3> Placeholder Progress bar</h3>

<div id="myProgress">
  <div id="progressBar">10%</div>
</div>

<button class = "button" onclick="move()"><span>Update</span></button>
</div>


<style>
#myProgress {
  width: 50%;
  background-color: #ddd;
}

#myBar {
  width: 10px;
  height: 30px;
  background-color: #04AA6D;
  text-align: center;
  line-height: 30px;
  color: white;
}

.button {
   width: 50%;
 }

 .button span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.button span:after {
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.button:hover span {
  padding-right: 25px;
}

.button:hover span:after {
  opacity: 1;
  right: 0;
}
</style>

<script>
var i = 0;
function move() {
  if (i == 0) {
    i = 1;
    var elem = document.getElementById("progressBar");
    var width = 10;
    var id = setInterval(frame, 10);
    function frame() {
      if (width >= 100) {
        clearInterval(id);
        i = 0;
      } else {
        width++;
        elem.style.width = width + "%";
        elem.innerHTML = width  + "%";
      }
    }
  }
}
</script>
';
?>

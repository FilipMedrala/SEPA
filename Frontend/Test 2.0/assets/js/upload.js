$('#chooseFile').bind('change', function () {
  var filename = $("#chooseFile").val();
  if (/^\s*$/.test(filename)) {
    $(".file-upload").removeClass('active');
    $("#noFile").text("No file chosen..."); 
  }
  else {
    $(".file-upload").addClass('active');
    $("#noFile").text(filename.replace("C:\\fakepath\\", "")); 
  }
});

$('#chooseFile2').bind('change', function () {
  var filename2 = $("#chooseFile2").val();
  if (/^\s*$/.test(filename2)) {
    $(".file-upload2").removeClass('active');
    $("#noFile2").text("No file chosen..."); 
  }
  else {
    $(".file-upload2").addClass('active');
    $("#noFile2").text(filename2.replace("C:\\fakepath\\", "")); 
  }
});

 $("#radio-src").click(function() {
    $("#compiler").attr("disabled", false);
    $("#compiler").show(); //To Show the dropdown
});

$("#radio-bin").click(function() {
    $("#compiler").attr("disabled", true);
    $("#compiler").hide();//To hide the dropdown
});
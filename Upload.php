<!DOCTYPE html>
<!-- This page contains the upload function -->
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="keywords" content="upload, fuzzing" />
  <meta name="description" content="Page for uploading">
  <meta name="author" content="Group 23" />
 <link href= "styles/style.css" rel="stylesheet"

	<title> Upload </title>
</head>
<body id = "uploadPage">
  <section id = "top">
  <?php
    include ("header.inc");
    include ("navbar.inc");
  ?>
  </section>
  <article>

  <form action="upload.php" method="post" enctype="multipart/form-data">
      Select file to upload:
  <input type="file" name="fileToUpload" id="fileToUpload">
  <input type="submit" value="Upload File" name="submit">
  </form>
  </article>

  <section id = "bottom">

  <?php
    include ("footer.inc");
  ?>
  </section>
</body>
</html>

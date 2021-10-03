<?php require 'config/cfg-ip-acl.req';?>
<?php require 'config/cfg-ssl.req';?>
<!DOCTYPE html>
<html class="h-100">
<?php include 'ui/ui-header-index.inc';?>
<body class="d-flex flex-column h-100">
<?php include 'ui/ui-nav-static.inc';?>

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
<div>

<p>Previous Items Fuzzed</p>
<table>
 <tr>
   <th>Job 1</th>
   <td>Test</td>
   <td>5</td>
 </tr>
 <tr>
   <th>Job 2</th>
   <td>Test</td>
   <td>5</td>
 </tr>
 <tr>
   <th>Job 3</th>
   <td>Test</td>
   <td>14</td>
 </tr>
</table>
</div>

<style>
table {
  border-collapse: collapse;
  width: 100%;
}

th, td {
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #D6EEEE;
}
</style>


<?php include 'ui/ui-footer.inc';?>
</body>
</html>

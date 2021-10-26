# Maria database documentation

### Table
Table files stores information that are used to retrieve user’s history of fuzzing and file location of retrieved files.

| uID | Date | Adr | File |
|-----|------|------|------|
|43562|18/10/2021|htdocs/43562|my_fuzzing_file|
|12345|10/10/2021|documents/12345|fuzz_goat|
|54321|1/09/2021|my_files/54321|test_1|
 
### Attributes
*	uID – user id attribute storing a unique user ID retrieved from firebase.
*	Date – date of fuzzing
*	Adr – directiory where fuzzed files are stored
*	File – name of fuzzed files
### Access
MariaDB can be accessed with:

•	[MariaDB Website](https://mariadb.org/)
•	[Official database image](https://hub.docker.com/_/mariadb)

### Setup guide
To connect to database find a “settings.php” files located in the website directory. Following code is inside:

```php
<?php
$host = "";
$user = "";
$pwd = "";
$sql_db = "";
?>
```

Between quote sings type in your database host address, your user name , password to your account and database name. Save the file and login to the website. 
Files table will be automatically created in your database and product will be ready to use. In case of failure appropriate message will be displayed to help you with problem identification.


<?php

$host = "localhost";#maybe sometime apache???
$user = "user12";
$pass = "34klq*";
$db = "mydb";

$r = mysql_connect($host,$user,$pass);

if(!$r) {
	echo "Could not connect to server\n";
	trigger_error(mysql_error(), E_USER_ERROR);
} else {
	echo "Connection established\n";
}

$r2 = mysql_select_db($db);

if(!$r2) {
	echo "Cannot select database $db \n";
	trigger_error(mysql_error(), E_USER_ERROR);
} else {
	echo "Database selected\n";
}

$query = "SELECT * FROM Cars WHERE Id IN (1,2,3)";

$rs = mysql_query($query);

if(!$rs) {
	echo 
	"Could not execute query: $query\n";
	trigger_error(mysql_error(), E_USER_ERROR);
} else {
	echo "Query: $query executed\n";
}

echo "We have " . mysql_num_fields($rs) . " fields\n";
echo "We have " . mysql_num_rows($rs) . " rows\n";

print_r(mysql_fetch_row($rs));

mysql_close();

?>
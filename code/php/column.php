<?php

$host ="localhost";
$user="user12";
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
	echo "Cannot select database\n";
	trigger_error(mysql_error(), E_USER_ERROR);
} else {
	echo "Database selected\n";
}

$query = "SELECT * From Cars LIMIT 8";

$rs = mysql_query($query);

if(!$rs) {
	echo "Could not execute query: $query";
	trigger_error(mysql_error, E_USER_ERROR);
} else {
	echo "Query: $query executed\n";
}

$cname1 = mysql_fetch_field($rs,0);
$cname2 = mysql_fetch_field($rs,1);
$cname3 = mysql_fetch_field($rs,2);

printf("%3s %-11s %8s\n",$cname1->name, $cname2->name,$cname3->name);

while ($row = mysql_fetch_row($rs)) {
	printf("%3s %-11s %8s\n",$row[0],$row[1],$row[2]);
}

mysql_close();

?>
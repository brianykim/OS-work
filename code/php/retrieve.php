<?php

$host = "localhost";
$user = "user12";
$pass = "34klq*";
$db = "mydb";

$r = mysql_connect($host,$user,$pass);
if(!$r)
{
	echo "Could not connect to server\n";
	trigger_error(mysql_error(), E_USER_ERROR);
} else {
	echo "Connection established\n";
}

$r2 = mysql_select_db($db);

if (!$r2){
	echo "Cannot select database\n";
	trigger_error(mysql_error(), E_USER_ERROR);
} else {
	echo "Database selected\n";
}

$name = "O'Neill";
$name_es = mysql_real_escape_string($name);
$query = "INSERT INTO AUTHORS(Name) VALUES('$name_es')";
#$query = sprintf("SELECT Id, Name, Price From Cars Where Name = '%s'",mysql_real_escape_string($name));
$query = "COMMIT"
$rs = mysql_query($query);

if(!$rs)
{
	echo "Could not execute query: $query";
	trigger_error(mysql_error(), E_USER_ERROR);
} else {
	echo "Query: $query executed\n";
}

#noted, important in PHP, error messages, and sanitizing data by escaping
/*while ($row = mysql_fetch_object($rs)) {
	echo $row -> Id;
	echo " ";
	echo $row -> Name;
	echo " ";
	echo $row -> Price;
	echo "\n";
}
START person=node:persons("name:*") RETURN person.name, count(*)
ORDER BY person.name*/
/*
$nrows=mysql_num_rows($rs);

for($i=0; $i<$nrows;$i++)
{
	$row=mysql_fetch_row($rs);
	echo $row[0];
	echo " " .  $row[1];
	echo " ";
	echo $row[2];
	echo "\n";
}*/
/*while ($row = mysql_fetch_assoc($rs)) {
	echo $row['Id'] . " " . $row['Name'] . " " . $row['Price'] . "\n";
}
*/
mysql_close();

?>
<?php

$host = "localhost";
$user="user12";
$pass= "34klq*";

$r = mysql_connect($host,$user,$pass);

if(!$r){
	echo "Could not connect to server\n";
	trigger_error(mysql_error(), E_USER_ERROR);
}
else {
	echo "Connection established\n";
}

echo mysql_get_server_info() . "\n";

mysql_close();

?>
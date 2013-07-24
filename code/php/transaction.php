<?php

mysql_connect('localhost','user12','34klq*')
	or die("cannot connect to database\n");

mysql_select_db("mydb") or die (mysql_error());

$r1 = mysql_query("UPDATE Cars SET Name = 'Leo Tolstoy' WHERE Id = 1")
	or die(mysql_error());

$r2 = mysql_query("UPDATE Cars SET Name = 'Boris Pasternak' WHERE Id = 2")
	or die (mysql_error());

$r3 = mysql_query("UPDATE Cars SET Name = 'Leonid Leonov' WHERE Id = 3")
	or die (mysql_error());

mysql_close();

?>
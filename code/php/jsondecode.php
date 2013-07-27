<?php
	$filename ="output.txt";
	$file = fopen($filename,"r");
	if($file==false)
	{
		echo("Error in opening file");
		exit();
	}
	$filesize=filesize($filename);
	$text = fread($file,$filesize);
	fclose($file);
	var_dump(json_decode($text));
	var_dump(json_decode($text,true));
	


?>
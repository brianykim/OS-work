<?php

	$json_baseurl = 'http://api.dev.onescreen.net/v2/internal/accounts.json?limit=100&offset=';

	$filename = "output.txt";
	$file=fopen($filename,"w");
	if($file==false)
	{
		echo ("Error opening file");
		exit();
	}
	for($i=1;$i<=19;$i++)
	{
		$json_url=$json_baseurl . $i;
		$curl=curl_init($json_url);
		$options=array(CURLOPT_RETURNTRANSFER=>true, CURLOPT_HTTPHEADER=>array('Content-type: applicatoin/json'));
		curl_setopt_array($curl, $options);
		$result=curl_exec($curl);
		fwrite($file, $result);

	}
?>
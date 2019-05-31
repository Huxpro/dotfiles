<?php

$blocked   = json_decode(file_get_contents('blocked-sites.json'));
$blocked[] = $query;

sort($blocked);

file_put_contents('blocked-sites.json', json_encode($blocked));

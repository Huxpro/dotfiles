<?php

$blocked = json_decode(file_get_contents('blocked-sites.json'));

$index = array_search($query, $blocked);

if ($index !== false) {
    unset($blocked[$index]);
    $blocked = array_values($blocked);
    file_put_contents('blocked-sites.json', json_encode($blocked));
}

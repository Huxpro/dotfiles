<?php

$blocked = json_decode(file_get_contents('blocked-sites.json'));
$addresses = ['127.0.0.1', 'fe80::1%lo0', '::1'];

$entries = [];

foreach ($addresses as $address) {
    foreach ($blocked as $site) {
        $entries[] = $address . ' ' . $site . ' www.' . $site;
    }
}

$current = explode("\n", file_get_contents('/etc/hosts'));

$header = '### Focus Time.';

$index = array_search($header, $current);

<?php

require 'entries.php';

if ($index === false) {
    $current[] = $header;
    $current = array_merge($current, $entries);

    file_put_contents('/etc/hosts', implode("\n", $current));
    exec('sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder');
}

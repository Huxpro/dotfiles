<?php
require 'entries.php';

if ($index !== false) {
    unset($current[$index]);

    foreach ($entries as $entry) {
        $index = array_search($entry, $current);
        if ($index !== false) {
            unset($current[$index]);
        }
    }

    file_put_contents('/etc/hosts', implode("\n", $current));
}

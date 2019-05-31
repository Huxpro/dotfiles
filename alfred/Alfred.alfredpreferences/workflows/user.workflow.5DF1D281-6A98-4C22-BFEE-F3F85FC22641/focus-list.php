<?php

use Alfred\Workflows\Workflow;

require 'vendor/autoload.php';

$workflow = new Workflow;

$blocked = json_decode(file_get_contents('blocked-sites.json')) ?: [];

foreach ($blocked as $site) {
    $workflow->result()
                ->arg($site)
                ->autocomplete($site)
                ->title($site)
                ->subtitle('Remove from blocked sites', 'cmd')
                ->icon('remove.png');
}

$workflow->sortResults()->filterResults($query);

echo $workflow->output();

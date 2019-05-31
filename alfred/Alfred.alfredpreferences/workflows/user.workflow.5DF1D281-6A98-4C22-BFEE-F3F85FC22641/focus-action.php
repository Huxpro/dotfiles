<?php

use Alfred\Workflows\Workflow;

require 'vendor/autoload.php';

$workflow = new Workflow;

$workflow->result()
            ->arg($query)
            ->title(sprintf('Add %s to blocked sites', $query))
            ->icon('add-site.png');

echo $workflow->output();

<?php
require __DIR__ . '/../vendor/autoload.php';
use RBertolli\openHBot\Webhook;
$webhook = new Webhook();
echo $webhook->handle();

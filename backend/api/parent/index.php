<?php
declare(strict_types=1);

require_once dirname(__DIR__, 2) . '/bootstrap.php';

respond([
    'success' => true,
    'message' => 'Parent API namespace ready',
]);

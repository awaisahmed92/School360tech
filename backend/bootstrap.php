<?php
declare(strict_types=1);

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(204);
    exit;
}

function json_input(): array
{
    $raw = file_get_contents('php://input') ?: '{}';
    $decoded = json_decode($raw, true);
    return is_array($decoded) ? $decoded : [];
}

function respond(array $data, int $status = 200): never
{
    http_response_code($status);
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function master_config(): array
{
    return [
        'host' => getenv('MASTER_HOST') ?: '127.0.0.1',
        'port' => getenv('MASTER_PORT') ?: '3306',
        'name' => getenv('MASTER_DB') ?: 'hr360_master',
        'user' => getenv('MASTER_USER') ?: 'root',
        'pass' => getenv('MASTER_PASS') !== false ? (string) getenv('MASTER_PASS') : '',
    ];
}

function match_key(string $raw): string
{
    $key = strtolower(trim($raw));
    $key = preg_replace('/[^a-z0-9]+/', '', $key) ?? '';

    return substr($key, 0, 40);
}

function master_pdo(): PDO
{
    static $pdo = null;
    if ($pdo instanceof PDO) {
        return $pdo;
    }

    $cfg = master_config();
    if (!preg_match('/^[A-Za-z0-9_]+$/', $cfg['name'])) {
        throw new RuntimeException('The master database name is not valid.');
    }

    $server = new PDO(
        "mysql:host={$cfg['host']};port={$cfg['port']};charset=utf8mb4",
        $cfg['user'],
        $cfg['pass'],
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
    $server->exec(
        "CREATE DATABASE IF NOT EXISTS `{$cfg['name']}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
    );

    $pdo = new PDO(
        "mysql:host={$cfg['host']};port={$cfg['port']};dbname={$cfg['name']};charset=utf8mb4",
        $cfg['user'],
        $cfg['pass'],
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]
    );
    ensure_master_tenant_columns($pdo);

    return $pdo;
}

function ensure_master_tenant_columns(PDO $master): void
{
    $dbName = master_config()['name'];
    $needed = [
        'accounts_app' => 'TINYINT(1) NOT NULL DEFAULT 0',
        'pos_app' => 'TINYINT(1) NOT NULL DEFAULT 0',
        'school_app' => 'TINYINT(1) NOT NULL DEFAULT 0',
        'accounts_db_name' => 'VARCHAR(191) NULL',
        'pos_db_name' => 'VARCHAR(191) NULL',
        'school_db_name' => 'VARCHAR(191) NULL',
        'company_code' => 'VARCHAR(100) NULL',
    ];
    $stmt = $master->prepare(
        'SELECT COLUMN_NAME FROM information_schema.COLUMNS
         WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?'
    );
    $stmt->execute([$dbName, 'tenants']);
    $present = array_column($stmt->fetchAll(), 'COLUMN_NAME');
    if ($present === []) {
        throw new RuntimeException('hr360_master.tenants is missing. Run database/master/01_master.sql first.');
    }
    foreach ($needed as $column => $definition) {
        if (!in_array($column, $present, true)) {
            $master->exec("ALTER TABLE `tenants` ADD COLUMN `{$column}` {$definition}");
        }
    }
}

/**
 * The shared hr360_master.tenants row for this company.
 * School data lives in school_db_name; the company itself is the same row HR, Accounts, and POS use.
 *
 * @return array{id: int, name: string, subdomain: string, company_code: string, school_db_name: string}
 */
function resolve_school_tenant(string $companyCode): array
{
    $key = match_key($companyCode);
    if ($key === '') {
        throw new InvalidArgumentException('Company code is required.');
    }

    $master = master_pdo();
    $rows = $master->query(
        'SELECT id, name, subdomain, company_code, status, school_app, school_db_name FROM tenants'
    )->fetchAll();

    $match = null;
    foreach ($rows as $row) {
        $codes = array_filter([
            match_key((string) ($row['company_code'] ?? '')),
            match_key((string) ($row['subdomain'] ?? '')),
        ]);
        if (in_array($key, $codes, true)) {
            $match = $row;
            break;
        }
    }

    if ($match === null) {
        throw new RuntimeException('No company with that code is registered in the 360 master.');
    }
    if (($match['status'] ?? '') !== 'active') {
        throw new RuntimeException('This company is not active.');
    }
    if ((int) ($match['school_app'] ?? 0) !== 1) {
        throw new RuntimeException('School360tech is not enabled for this company.');
    }

    $dbName = trim((string) ($match['school_db_name'] ?? ''));
    if ($dbName === '') {
        $dbName = 'school360_' . $key;
        $master->prepare('UPDATE tenants SET school_db_name = ? WHERE id = ?')
            ->execute([$dbName, $match['id']]);
    }
    if (!preg_match('/^[A-Za-z0-9_]+$/', $dbName)) {
        throw new RuntimeException('The school database name on this company is not valid.');
    }

    return [
        'id' => (int) $match['id'],
        'name' => (string) $match['name'],
        'subdomain' => (string) $match['subdomain'],
        'company_code' => (string) ($match['company_code'] ?: $match['subdomain']),
        'school_db_name' => $dbName,
    ];
}

function db_connection(string $companyCode): PDO
{
    $tenant = resolve_school_tenant($companyCode);
    $cfg = master_config();
    $dbName = $tenant['school_db_name'];
    $dsn = "mysql:host={$cfg['host']};port={$cfg['port']};dbname={$dbName};charset=utf8mb4";

    return new PDO($dsn, $cfg['user'], $cfg['pass'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);
}

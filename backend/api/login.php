<?php
declare(strict_types=1);

require_once dirname(__DIR__) . '/bootstrap.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    respond(['success' => false, 'message' => 'Method not allowed'], 405);
}

$payload = json_input();
$subdomain = trim((string)($payload['subdomain'] ?? ''));
$email = trim((string)($payload['email'] ?? ''));
$password = (string)($payload['password'] ?? '');

if ($subdomain === '' || $email === '' || $password === '') {
    respond(['success' => false, 'message' => 'subdomain, email and password are required'], 422);
}

try {
    $pdo = db_connection($subdomain);
    $stmt = $pdo->prepare(
        "SELECT id, name, email, role, password_hash, is_active
         FROM users
         WHERE email = :email
         LIMIT 1"
    );
    $stmt->execute(['email' => $email]);
    $user = $stmt->fetch();

    if (!$user || (int)$user['is_active'] !== 1) {
        respond(['success' => false, 'message' => 'Invalid credentials'], 401);
    }

    if (!password_verify($password, (string)$user['password_hash'])) {
        respond(['success' => false, 'message' => 'Invalid credentials'], 401);
    }

    $token = base64_encode(hash('sha256', $user['email'] . '|' . microtime(true), true));

    $pdo->prepare("UPDATE users SET last_login_at = NOW() WHERE id = :id")
        ->execute(['id' => $user['id']]);

    respond([
        'success' => true,
        'data' => [
            'token' => $token,
            'user' => [
                'id' => (int)$user['id'],
                'name' => (string)$user['name'],
                'email' => (string)$user['email'],
                'role' => (string)$user['role'],
                'avatar_path' => null,
            ],
            'company' => [
                'subdomain' => $subdomain,
                'name' => strtoupper($subdomain) . ' School',
                'logo_path' => null,
                'currency' => 'PKR',
            ],
        ],
    ]);
} catch (Throwable $e) {
    respond([
        'success' => false,
        'message' => 'Server error',
        'detail' => $e->getMessage(),
    ], 500);
}

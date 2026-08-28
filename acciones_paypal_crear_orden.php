<?php
session_start();
require_once __DIR__ . '/admin/db/conexion.php';
require_once __DIR__ . '/admin/db/config_paypal.php';

header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['ok' => false, 'error' => 'Sesion no valida.']);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode(['ok' => false, 'error' => 'Metodo no permitido.']);
    exit();
}

$raw = file_get_contents('php://input');
$data = json_decode($raw, true);
$orderUuid = isset($data['order_uuid']) ? trim($data['order_uuid']) : '';

if ($orderUuid === '') {
    echo json_encode(['ok' => false, 'error' => 'Orden no enviada.']);
    exit();
}

if (!defined('PAYPAL_CLIENT_ID') || PAYPAL_CLIENT_ID === 'REEMPLAZAR_CLIENT_ID' || !defined('PAYPAL_CLIENT_SECRET') || PAYPAL_CLIENT_SECRET === 'REEMPLAZAR_CLIENT_SECRET') {
    echo json_encode(['ok' => false, 'error' => 'PayPal no configurado.']);
    exit();
}

try {
    $stmt = $pdo->prepare('SELECT id, total, estado FROM orders WHERE order_uuid = ? AND user_id = ? LIMIT 1');
    $stmt->execute([$orderUuid, $_SESSION['user_id']]);
    $orden = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$orden) {
        throw new Exception('Orden no valida.');
    }

    if ($orden['estado'] !== 'PENDIENTE') {
        throw new Exception('La orden ya no esta pendiente de pago.');
    }

    $montoTotal = (float)$orden['total'] + 5.00;
    $montoFormateado = number_format($montoTotal, 2, '.', '');

    $accessToken = paypal_access_token();

    $payload = [
        'intent' => 'CAPTURE',
        'purchase_units' => [[
            'reference_id' => $orderUuid,
            'custom_id' => $orderUuid,
            'amount' => [
                'currency_code' => 'USD',
                'value' => $montoFormateado
            ],
            'description' => 'Compra ANUMA - Orden ' . $orderUuid
        ]]
    ];

    $response = paypal_request('/v2/checkout/orders', $accessToken, $payload);

    if (empty($response['id'])) {
        throw new Exception('PayPal no devolvio el ID de orden.');
    }

    echo json_encode([
        'ok' => true,
        'paypal_order_id' => $response['id']
    ]);
} catch (Exception $e) {
    echo json_encode([
        'ok' => false,
        'error' => $e->getMessage()
    ]);
}

function paypal_access_token() {
    $url = paypal_base_url() . '/v1/oauth2/token';
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => 'grant_type=client_credentials',
        CURLOPT_HTTPHEADER => [
            'Accept: application/json',
            'Accept-Language: es_EC'
        ],
        CURLOPT_USERPWD => PAYPAL_CLIENT_ID . ':' . PAYPAL_CLIENT_SECRET,
        CURLOPT_TIMEOUT => 30,
    ]);

    $response = curl_exec($ch);
    if ($response === false) {
        $error = curl_error($ch);
        curl_close($ch);
        throw new Exception('Error cURL PayPal: ' . $error);
    }

    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    $json = json_decode($response, true);
    if ($httpCode < 200 || $httpCode >= 300 || empty($json['access_token'])) {
        throw new Exception('No se pudo autenticar con PayPal.');
    }

    return $json['access_token'];
}

function paypal_request($path, $token, $payload) {
    $url = paypal_base_url() . $path;
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($payload),
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json',
            'Authorization: Bearer ' . $token
        ],
        CURLOPT_TIMEOUT => 30,
    ]);

    $response = curl_exec($ch);
    if ($response === false) {
        $error = curl_error($ch);
        curl_close($ch);
        throw new Exception('Error cURL PayPal: ' . $error);
    }

    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    $json = json_decode($response, true);
    if ($httpCode < 200 || $httpCode >= 300) {
        throw new Exception('PayPal rechazo la solicitud de creacion.');
    }

    return $json;
}

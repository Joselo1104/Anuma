<?php
session_start();
require_once __DIR__ . '/admin/db/conexion.php';
require_once __DIR__ . '/admin/db/config_paypal.php';

$paypalMode = defined('PAYPAL_MODE') ? PAYPAL_MODE : 'sandbox';
$paypalClientId = defined('PAYPAL_CLIENT_ID') ? PAYPAL_CLIENT_ID : '';
$paypalClientSecret = defined('PAYPAL_CLIENT_SECRET') ? PAYPAL_CLIENT_SECRET : '';

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
$paypalOrderId = isset($data['paypal_order_id']) ? trim($data['paypal_order_id']) : '';

if ($orderUuid === '' || $paypalOrderId === '') {
    echo json_encode(['ok' => false, 'error' => 'Datos incompletos.']);
    exit();
}

if ($paypalClientId === '' || $paypalClientId === 'REEMPLAZAR_CLIENT_ID' || $paypalClientSecret === '' || $paypalClientSecret === 'REEMPLAZAR_CLIENT_SECRET') {
    echo json_encode(['ok' => false, 'error' => 'PayPal no configurado.']);
    exit();
}

try {
    $stmt = $pdo->prepare('SELECT id, estado FROM orders WHERE order_uuid = ? AND user_id = ? LIMIT 1');
    $stmt->execute([$orderUuid, $_SESSION['user_id']]);
    $orden = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$orden) {
        throw new Exception('Orden no valida.');
    }

    if ($orden['estado'] !== 'PENDIENTE') {
        throw new Exception('La orden no esta pendiente de pago.');
    }

    $accessToken = paypal_access_token($paypalMode, $paypalClientId, $paypalClientSecret);
    $capture = paypal_capture_order($paypalOrderId, $accessToken, $paypalMode);

    $captureStatus = $capture['status'] ?? '';
    if ($captureStatus !== 'COMPLETED') {
        throw new Exception('PayPal no confirmo el pago.');
    }

    $pdo->beginTransaction();

    $stmtUpdate = $pdo->prepare("UPDATE orders SET estado = 'PAGADO', metodo_pago = 'PAYPAL', actualizado_en = NOW() WHERE id = ?");
    $stmtUpdate->execute([$orden['id']]);

    descontar_stock_por_orden($pdo, $orden['id']);

    $stmtItems = $pdo->prepare('SELECT producto_id FROM order_items WHERE order_id = ?');
    $stmtItems->execute([$orden['id']]);
    $items = $stmtItems->fetchAll(PDO::FETCH_ASSOC);

    $stmtDelete = $pdo->prepare('DELETE FROM carrito_compras WHERE user_id = ? AND producto_id = ?');
    foreach ($items as $item) {
        $stmtDelete->execute([$_SESSION['user_id'], $item['producto_id']]);
    }

    if (isset($_SESSION['carrito'])) {
        unset($_SESSION['carrito']);
    }

    $pdo->commit();

    echo json_encode([
        'ok' => true,
        'redirect' => 'pedido_confirmado.php?order=' . urlencode($orderUuid)
    ]);
} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    echo json_encode([
        'ok' => false,
        'error' => $e->getMessage()
    ]);
}

function descontar_stock_por_orden($pdo, $orderId) {
    $stmtItems = $pdo->prepare("SELECT producto_id, cantidad FROM order_items WHERE order_id = ?");
    $stmtItems->execute([$orderId]);
    $items = $stmtItems->fetchAll(PDO::FETCH_ASSOC);

    foreach ($items as $item) {
        $productoId = $item['producto_id'];
        $cantidadComprada = (int)$item['cantidad'];

        if ($cantidadComprada <= 0) {
            continue;
        }

        $stmtVariantes = $pdo->prepare("SELECT id, talla, stock FROM variantes WHERE producto_id = ? ORDER BY CASE WHEN talla = 'ÚNICA' THEN 0 ELSE 1 END, talla");
        $stmtVariantes->execute([$productoId]);
        $variantes = $stmtVariantes->fetchAll(PDO::FETCH_ASSOC);

        if (empty($variantes)) {
            continue;
        }

        $restante = $cantidadComprada;
        foreach ($variantes as $variante) {
            if ($restante <= 0) {
                break;
            }

            $stockActual = (int)$variante['stock'];
            if ($stockActual <= 0) {
                continue;
            }

            $aDescontar = min($restante, $stockActual);
            $restante -= $aDescontar;

            $stmtUpdate = $pdo->prepare("UPDATE variantes SET stock = stock - ? WHERE id = ?");
            $stmtUpdate->execute([$aDescontar, $variante['id']]);
        }

        if ($restante > 0) {
            throw new Exception("No hay suficiente stock para uno de los productos seleccionados.");
        }
    }
}

function paypal_access_token($paypalMode, $paypalClientId, $paypalClientSecret) {
    $url = paypal_api_base($paypalMode) . '/v1/oauth2/token';
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => 'grant_type=client_credentials',
        CURLOPT_HTTPHEADER => [
            'Accept: application/json',
            'Accept-Language: es_EC'
        ],
        CURLOPT_USERPWD => $paypalClientId . ':' . $paypalClientSecret,
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

function paypal_capture_order($paypalOrderId, $token, $paypalMode) {
    $url = paypal_api_base($paypalMode) . '/v2/checkout/orders/' . rawurlencode($paypalOrderId) . '/capture';
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => '{}',
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
        throw new Exception('PayPal rechazo la captura del pago.');
    }

    return $json;
}

function paypal_api_base($paypalMode) {
    return $paypalMode === 'live'
        ? 'https://api-m.paypal.com'
        : 'https://api-m.sandbox.paypal.com';
}

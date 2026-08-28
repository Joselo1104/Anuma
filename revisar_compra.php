<?php
session_start();
require_once "admin/db/conexion.php";
include('bases/header.php');
echo '<style>.header-strip { display: none !important; }</style>';

$paypal_client_id = '';
$paypal_mode = 'sandbox';
$paypal_disponible = false;

if (file_exists(__DIR__ . '/admin/db/config_paypal.php')) {
    require_once __DIR__ . '/admin/db/config_paypal.php';
    $paypal_client_id = defined('PAYPAL_CLIENT_ID') ? PAYPAL_CLIENT_ID : '';
    $paypal_mode = defined('PAYPAL_MODE') ? PAYPAL_MODE : 'sandbox';
    $paypal_disponible = !empty($paypal_client_id) && $paypal_client_id !== 'REEMPLAZAR_CLIENT_ID';
}

// Validar que llegue el ID de la orden
if (!isset($_GET['order'])) {
    header("Location: index.php");
    exit();
}

$order_uuid = $_GET['order'];

// Consultar la orden
$stmt = $pdo->prepare("SELECT * FROM orders WHERE order_uuid = ? AND user_id = ?");
$stmt->execute([$order_uuid, $_SESSION['user_id']]);
$orden = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$orden) {
    echo "<div style='padding:50px; text-align:center;'>Orden no válida.</div>";
    include('bases/footer.php');
    exit();
}

// Decodificar la dirección que guardamos en JSON
$direccion = json_decode($orden['direccion_envio'], true);

// Calcular envío (Simulado por ahora, puedes poner lógica real luego)
$costo_envio = 5.00; 
$subtotal = $orden['total']; 
$total_final = $subtotal + $costo_envio; // En tu DB guardaste el subtotal productos, aquí sumamos envío visualmente
?>

<link rel="stylesheet" href="style/css/revisar_compra.css">

<div class="revision-container">
    
    <h2>Revisa la forma de entrega</h2>

    <div class="card-revision direccion-box">
        <div class="info-texto">
            <p class="calle">
                <?php echo htmlspecialchars($direccion['calle_principal']); ?> - 
                <?php echo htmlspecialchars($direccion['canton']); ?>, 
                <?php echo htmlspecialchars($direccion['provincia']); ?>
            </p>
            <p class="tipo-domicilio"><?php echo htmlspecialchars($direccion['tipo']); ?></p>
        </div>
        
        <a href="checkout.php" class="link-modificar">Modificar domicilio o elegir otro</a>
    </div>

    <div class="resumen-seccion">
        <h2>Resumen de compra</h2>
        
        <div class="fila-resumen">
            <span>Producto(s)</span>
            <span>$<?php echo number_format($subtotal, 2); ?></span>
        </div>
        
        <div class="fila-resumen">
            <span>Envío</span>
            <span>$<?php echo number_format($costo_envio, 2); ?></span>
        </div>

        <div class="fila-resumen total">
            <span>Total</span>
            <span>$<?php echo number_format($total_final, 2); ?></span>
        </div>
    </div>

    <div class="acciones-finales">
        <h3 class="metodo-title">Metodo de pago</h3>
        <div class="metodo-pago-box">
            <div class="metodo-item">
                <strong>Contra entrega</strong>
                <span>Pagas al recibir tu pedido</span>
            </div>
        </div>
        <div class="metodo-pago-box paypal-box">
            <div class="metodo-item">
                <strong>PayPal</strong>
                <span>Paga en linea con tu cuenta o tarjeta</span>
            </div>

            <?php if ($paypal_disponible): ?>
                <div id="paypal-button-container"></div>
            <?php else: ?>
                <p class="paypal-aviso">PayPal no esta configurado todavia. Configura tu Client ID y Secret en admin/db/config_paypal.php.</p>
            <?php endif; ?>
        </div>
    </div>

</div>

<?php if ($paypal_disponible): ?>
<script src="https://www.paypal.com/sdk/js?client-id=<?php echo urlencode($paypal_client_id); ?>&currency=USD&intent=capture"></script>
<script>
    (function () {
        var orderUuid = <?php echo json_encode($order_uuid); ?>;

        paypal.Buttons({
            createOrder: function () {
                return fetch('acciones_paypal_crear_orden.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ order_uuid: orderUuid })
                })
                .then(function (res) { return res.json(); })
                .then(function (data) {
                    if (!data.ok) {
                        throw new Error(data.error || 'No se pudo crear la orden PayPal.');
                    }
                    return data.paypal_order_id;
                });
            },
            onApprove: function (data) {
                return fetch('acciones_paypal_capturar_orden.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        order_uuid: orderUuid,
                        paypal_order_id: data.orderID
                    })
                })
                .then(function (res) { return res.json(); })
                .then(function (data) {
                    if (!data.ok) {
                        throw new Error(data.error || 'No se pudo confirmar el pago.');
                    }
                    window.location.href = data.redirect;
                })
                .catch(function (err) {
                    alert(err.message || 'Error al capturar el pago con PayPal.');
                });
            },
            onError: function () {
                alert('Ocurrio un error con PayPal. Intenta de nuevo.');
            }
        }).render('#paypal-button-container');
    })();
</script>
<?php endif; ?>

<?php include('bases/footer.php'); ?>
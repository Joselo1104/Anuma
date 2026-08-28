<?php
session_start();
require_once "admin/db/conexion.php";
include('bases/header.php');

// Validar que llegue el ID de la orden
if (!isset($_GET['order'])) {
    echo "<script>window.location.href='index.php';</script>";
    exit();
}

$order_uuid = $_GET['order'];

// Consultar datos de la orden para mostrar en pantalla
$stmt = $pdo->prepare("SELECT * FROM orders WHERE order_uuid = ?");
$stmt->execute([$order_uuid]);
$orden = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$orden) {
    echo "<div style='padding:50px; text-align:center;'>Orden no encontrada.</div>";
    include('bases/footer.php');
    exit();
}

$estadoPedido = strtoupper($orden['estado'] ?? 'PENDIENTE');
$trackingMap = [
    'PENDIENTE' => [
        'titulo' => 'Pedido confirmado',
        'mensaje' => 'Tu pedido está siendo preparado y pronto será enviado.',
        'paso' => 1
    ],
    'PAGADO' => [
        'titulo' => 'Empaquetando',
        'mensaje' => 'Estamos preparando tu paquete para el despacho.',
        'paso' => 2
    ],
    'ENVIADO' => [
        'titulo' => 'En camino',
        'mensaje' => 'Tu pedido ya salió de nuestro almacén y está en tránsito.',
        'paso' => 3
    ],
    'COMPLETADO' => [
        'titulo' => 'Entregado',
        'mensaje' => 'Tu pedido ha sido entregado correctamente.',
        'paso' => 4
    ],
    'CANCELADO' => [
        'titulo' => 'Cancelado',
        'mensaje' => 'Este pedido fue cancelado y ya no está en tránsito.',
        'paso' => 0
    ]
];

$trackingInfo = $trackingMap[$estadoPedido] ?? $trackingMap['PENDIENTE'];
$trackingCode = $orden['tracking_code'] ?? null;

$stmtItems = $pdo->prepare("SELECT * FROM order_items WHERE order_id = ? ORDER BY id ASC");
$stmtItems->execute([$orden['id']]);
$itemsPedido = $stmtItems->fetchAll(PDO::FETCH_ASSOC);
?>

<link rel="stylesheet" href="style/css/pedido_confirmado.css">

<div class="confirmacion-container">
    <div class="card-exito">
        <div class="icono-exito">
            <i class="fas fa-check-circle"></i>
        </div>
        <h1>¡Gracias por tu compra!</h1>
        <p class="subtitulo">Tu pedido ha sido recibido correctamente.</p>

        <div class="detalles-orden">
            <p><strong>N° de Orden:</strong> <span class="uuid"><?php echo htmlspecialchars($orden['order_uuid']); ?></span></p>
            <p><strong>Total:</strong> $<?php echo number_format($orden['total'], 2); ?></p>
            <p><strong>Estado:</strong> <?php echo ucfirst(strtolower($orden['estado'])); ?></p>
            <p><strong>Fecha:</strong> <?php echo date('d/m/Y H:i', strtotime($orden['creado_en'])); ?></p>
        </div>

        <div class="productos-pedido">
            <div class="rastreo-header">
                <h3>Productos comprados</h3>
            </div>

            <?php if (!empty($itemsPedido)) : ?>
                <div class="tabla-productos">
                    <div class="fila encabezado">
                        <span>Producto</span>
                        <span>Cantidad</span>
                        <span>Subtotal</span>
                    </div>
                    <?php foreach ($itemsPedido as $item) : ?>
                        <div class="fila">
                            <span><?php echo htmlspecialchars($item['nombre_producto']); ?></span>
                            <span><?php echo (int) $item['cantidad']; ?></span>
                            <span>$<?php echo number_format($item['subtotal'], 2); ?></span>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php else : ?>
                <p class="codigo-rastreo">No hay productos registrados para este pedido.</p>
            <?php endif; ?>
        </div>

        <div class="rastreo-envio">
            <div class="rastreo-header">
                <h3>Rastreo del envío</h3>
                <span class="rastreo-estado"><?php echo htmlspecialchars($trackingInfo['titulo']); ?></span>
            </div>
            <p class="rastreo-mensaje"><?php echo htmlspecialchars($trackingInfo['mensaje']); ?></p>

            <?php if (!empty($trackingCode)) : ?>
                <p class="codigo-rastreo"><strong>Código de rastreo:</strong> <?php echo htmlspecialchars($trackingCode); ?></p>
            <?php else : ?>
                <p class="codigo-rastreo"><strong>Código de rastreo:</strong> Se asignará cuando el pedido sea enviado.</p>
            <?php endif; ?>

            <ul class="rastreo-etapas">
                <li class="<?php echo $trackingInfo['paso'] >= 1 ? 'activo' : ''; ?>">
                    <span>1</span>
                    <div><strong>Pedido confirmado</strong><small>Tu compra fue recibida.</small></div>
                </li>
                <li class="<?php echo $trackingInfo['paso'] >= 2 ? 'activo' : ''; ?>">
                    <span>2</span>
                    <div><strong>Empaquetado</strong><small>Se prepara para el despacho.</small></div>
                </li>
                <li class="<?php echo $trackingInfo['paso'] >= 3 ? 'activo' : ''; ?>">
                    <span>3</span>
                    <div><strong>En tránsito</strong><small>Tu paquete está en camino.</small></div>
                </li>
                <li class="<?php echo $trackingInfo['paso'] >= 4 ? 'activo' : ''; ?>">
                    <span>4</span>
                    <div><strong>Entregado</strong><small>El producto llegó a tu dirección.</small></div>
                </li>
            </ul>
        </div>

        <div class="botones-accion">
            <a href="index.php" class="btn-inicio">Volver al Inicio</a>
        </div>
    </div>
</div>

<?php include('bases/footer.php'); ?>
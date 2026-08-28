<?php
session_start();
require_once "admin/db/conexion.php";
include('bases/header.php');

echo '<style>.header-strip { display: none !important; }</style>';

if (!isset($_SESSION['user_id'])) {
    header('Location: usuario/login.php');
    exit();
}

$user_id = (int) $_SESSION['user_id'];
$por_pagina = 10;
$page = isset($_GET['page']) ? max(1, (int) $_GET['page']) : 1;
$offset = ($page - 1) * $por_pagina;

$stmtTotal = $pdo->prepare("SELECT COUNT(*) AS total FROM orders WHERE user_id = ?");
$stmtTotal->execute([$user_id]);
$totalPedidos = (int) $stmtTotal->fetch(PDO::FETCH_ASSOC)['total'];
$totalPaginas = max(1, (int) ceil($totalPedidos / $por_pagina));

$stmt = $pdo->prepare("SELECT * FROM orders WHERE user_id = ? ORDER BY creado_en DESC LIMIT ? OFFSET ?");
$stmt->bindValue(1, $user_id, PDO::PARAM_INT);
$stmt->bindValue(2, $por_pagina, PDO::PARAM_INT);
$stmt->bindValue(3, $offset, PDO::PARAM_INT);
$stmt->execute();
$pedidos = $stmt->fetchAll(PDO::FETCH_ASSOC);

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
?>

<style>
    .mis-pedidos-page {
        max-width: 1280px;
        margin: 40px auto 60px;
        padding: 0 20px;
    }

    .mis-pedidos-page h1 {
        font-size: 30px;
        color: #442D1C;
        margin-bottom: 8px;
    }

    .mis-pedidos-page p {
        color: #6b4a2f;
        margin-bottom: 24px;
    }

    .pedidos-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 20px;
    }

    .pedido-card {
        background: #fff;
        border: 1px solid #e8ddd1;
        border-radius: 14px;
        padding: 24px;
        margin-bottom: 0;
        box-shadow: 0 6px 18px rgba(68,45,28,0.06);
    }

    .pedido-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        flex-wrap: wrap;
        margin-bottom: 12px;
    }

    .pedido-header h3 {
        margin: 0;
        color: #442D1C;
        font-size: 18px;
    }

    .estado-chip {
        display: inline-flex;
        align-items: center;
        padding: 6px 12px;
        border-radius: 999px;
        font-size: 13px;
        font-weight: 700;
        background: #f5e7da;
        color: #743015;
    }

    .pedido-meta {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
        gap: 10px;
        margin-bottom: 14px;
        color: #6b4a2f;
        font-size: 14px;
    }

    .pedido-meta strong {
        display: block;
        color: #442D1C;
        margin-bottom: 3px;
    }

    .rastreo-mini {
        background: #fdf8f1;
        border: 1px solid #efe0c7;
        border-radius: 10px;
        padding: 14px;
        margin-top: 10px;
    }

    .rastreo-mini h4 {
        margin: 0 0 6px;
        font-size: 16px;
        color: #442D1C;
    }

    .rastreo-mini p {
        margin: 0 0 10px;
        font-size: 14px;
        color: #6b4a2f;
    }

    .rastreo-mini ul {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }

    .rastreo-mini li {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 10px;
        border-radius: 999px;
        background: #fff;
        border: 1px solid #e9d8bd;
        font-size: 12px;
        color: #6b4a2f;
    }

    .rastreo-mini li.activo {
        background: #743015;
        color: #fff;
        border-color: #743015;
    }

    .btn-confirmacion {
        display: inline-block;
        margin-top: 12px;
        background: #442D1C;
        color: #fff;
        text-decoration: none;
        padding: 10px 14px;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 700;
    }

    .btn-confirmacion:hover {
        background: #5f361f;
    }

    .empty-state {
        background: #fff;
        border: 1px dashed #d7c1a0;
        border-radius: 14px;
        padding: 24px;
        text-align: center;
        color: #6b4a2f;
    }

    .paginacion {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        margin-top: 24px;
        flex-wrap: wrap;
    }

    .paginacion a,
    .paginacion span {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 38px;
        height: 38px;
        padding: 0 12px;
        border-radius: 999px;
        text-decoration: none;
        background: #fff;
        border: 1px solid #e8ddd1;
        color: #442D1C;
        font-weight: 700;
    }

    .paginacion .actual {
        background: #442D1C;
        color: #fff;
        border-color: #442D1C;
    }

    /* ========================================================== */
    /* RESPONSIVO PARA MÓVILES (< 768px)                          */
    /* ========================================================== */
    @media (max-width: 768px) {
        .mis-pedidos-page {
            margin: 15px auto 50px !important;
            padding: 0 12px !important;
        }

        .mis-pedidos-page h1 {
            font-size: 24px;
        }

        .mis-pedidos-page p {
            font-size: 14px;
            margin-bottom: 16px;
        }

        /* 1. Cambio de 2 columnas a 1 columna vertical amplia */
        .pedidos-grid {
            grid-template-columns: 1fr !important;
            gap: 16px !important;
        }

        /* 2. Tarjeta con mejor espaciado interno */
        .pedido-card {
            padding: 16px !important;
            border-radius: 12px;
        }

        .pedido-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 8px;
        }

        .pedido-header h3 {
            font-size: 16px;
            word-break: break-all; /* Evita que códigos largos desborden la pantalla */
        }

        /* 3. Pasos de rastreo adaptables */
        .rastreo-mini {
            padding: 12px;
        }

        .rastreo-mini ul {
            gap: 6px;
        }

        .rastreo-mini li {
            font-size: 11px;
            padding: 5px 8px;
        }

        /* 4. Botón de acción ancho completo */
        .btn-confirmacion {
            display: block !important;
            width: 100% !important;
            text-align: center;
            box-sizing: border-box;
            padding: 12px 14px;
        }
    }

    
</style>

<div class="mis-pedidos-page">
    <h1>Mis pedidos</h1>
    <p>Aquí puedes ver el estado de tus compras y el avance del envío.</p>

    <?php if (empty($pedidos)) : ?>
        <div class="empty-state">
            <p>No tienes pedidos registrados aún.</p>
        </div>
    <?php else : ?>
        <div class="pedidos-grid">
            <?php foreach ($pedidos as $pedido) : ?>
                <?php
                    $estadoPedido = strtoupper($pedido['estado'] ?? 'PENDIENTE');
                    $trackingInfo = $trackingMap[$estadoPedido] ?? $trackingMap['PENDIENTE'];
                ?>
                <div class="pedido-card">
                    <div class="pedido-header">
                        <h3>Pedido #<?php echo htmlspecialchars($pedido['order_uuid']); ?></h3>
                        <span class="estado-chip"><?php echo ucfirst(strtolower($estadoPedido)); ?></span>
                    </div>

                    <div class="pedido-meta">
                        <div>
                            <strong>Total</strong>
                            $<?php echo number_format($pedido['total'], 2); ?>
                        </div>
                        <div>
                            <strong>Fecha</strong>
                            <?php echo date('d/m/Y H:i', strtotime($pedido['creado_en'])); ?>
                        </div>
                        <div>
                            <strong>Método de pago</strong>
                            <?php echo htmlspecialchars($pedido['metodo_pago'] ?? 'No especificado'); ?>
                        </div>
                    </div>

                    <div class="rastreo-mini">
                        <h4><?php echo htmlspecialchars($trackingInfo['titulo']); ?></h4>
                        <p><?php echo htmlspecialchars($trackingInfo['mensaje']); ?></p>
                        <ul>
                            <li class="<?php echo $trackingInfo['paso'] >= 1 ? 'activo' : ''; ?>">✓ Pedido confirmado</li>
                            <li class="<?php echo $trackingInfo['paso'] >= 2 ? 'activo' : ''; ?>">✓ Empaquetado</li>
                            <li class="<?php echo $trackingInfo['paso'] >= 3 ? 'activo' : ''; ?>">✓ En tránsito</li>
                            <li class="<?php echo $trackingInfo['paso'] >= 4 ? 'activo' : ''; ?>">✓ Entregado</li>
                        </ul>
                    </div>

                    <a href="pedido_confirmado.php?order=<?php echo urlencode($pedido['order_uuid']); ?>" class="btn-confirmacion">Ver detalle del pedido</a>
                </div>
            <?php endforeach; ?>
        </div>

        <?php if ($totalPaginas > 1) : ?>
            <div class="paginacion">
                <?php if ($page > 1) : ?>
                    <a href="mis_pedidos.php?page=<?php echo $page - 1; ?>">&laquo;</a>
                <?php endif; ?>

                <?php for ($i = 1; $i <= $totalPaginas; $i++) : ?>
                    <?php if ($i == $page) : ?>
                        <span class="actual"><?php echo $i; ?></span>
                    <?php else : ?>
                        <a href="mis_pedidos.php?page=<?php echo $i; ?>"><?php echo $i; ?></a>
                    <?php endif; ?>
                <?php endfor; ?>

                <?php if ($page < $totalPaginas) : ?>
                    <a href="mis_pedidos.php?page=<?php echo $page + 1; ?>">&raquo;</a>
                <?php endif; ?>
            </div>
        <?php endif; ?>
    <?php endif; ?>
</div>

<?php include('bases/footer.php'); ?>

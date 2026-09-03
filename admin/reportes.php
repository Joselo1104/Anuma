<?php
session_start();
if (!isset($_SESSION['admin_id'])) {
    header('Location: Alogin.php');
    exit();
}

require_once 'db/conexion.php';

$desde = isset($_GET['desde']) && is_string($_GET['desde']) ? $_GET['desde'] : '';
$hasta = isset($_GET['hasta']) && is_string($_GET['hasta']) ? $_GET['hasta'] : '';

$esFechaValida = static function ($fecha) {
    $objetoFecha = DateTime::createFromFormat('!Y-m-d', $fecha);
    return $objetoFecha && $objetoFecha->format('Y-m-d') === $fecha;
};

if (($desde !== '' && !$esFechaValida($desde)) || ($hasta !== '' && !$esFechaValida($hasta))) {
    $desde = '';
    $hasta = '';
}
if ($desde !== '' && $hasta !== '' && $desde > $hasta) {
    [$desde, $hasta] = [$hasta, $desde];
}

$filtroFecha = '';
$parametrosFecha = [];
if ($desde !== '') {
    $filtroFecha .= ' AND o.creado_en >= ?';
    $parametrosFecha[] = $desde . ' 00:00:00';
}
if ($hasta !== '') {
    $filtroFecha .= ' AND o.creado_en < DATE_ADD(?, INTERVAL 1 DAY)';
    $parametrosFecha[] = $hasta . ' 00:00:00';
}

$estadosFacturables = "('PAGADO', 'COMPLETADO')";

$stmtMetricas = $pdo->query("SELECT
    COALESCE(SUM(CASE WHEN estado IN $estadosFacturables THEN total ELSE 0 END), 0) AS facturado_historico,
    COALESCE(SUM(CASE WHEN estado IN $estadosFacturables
        AND creado_en >= DATE_FORMAT(CURRENT_DATE, '%Y-%m-01') THEN total ELSE 0 END), 0) AS facturado_mes,
    COUNT(*) AS total_pedidos,
    SUM(estado IN ('CANCELADO', 'PENDIENTE')) AS pedidos_no_concretados,
    COALESCE(AVG(CASE WHEN estado IN $estadosFacturables THEN total END), 0) AS ticket_promedio
    FROM orders");
$metricas = $stmtMetricas->fetch();

$sqlFiltradas = "SELECT o.order_uuid, CONCAT(u.nombres, ' ', u.apellidos) AS cliente,
    o.creado_en, o.metodo_pago, o.total, o.estado
    FROM orders o
    INNER JOIN users u ON u.id = o.user_id
    WHERE 1 = 1 $filtroFecha
    ORDER BY o.creado_en DESC";
$stmtFiltradas = $pdo->prepare($sqlFiltradas);
$stmtFiltradas->execute($parametrosFecha);
$pedidosFiltrados = $stmtFiltradas->fetchAll();
$totalPedidosFiltrados = count($pedidosFiltrados);
$pedidosPorPagina = 10;
$paginaActual = isset($_GET['pagina']) && is_string($_GET['pagina']) && ctype_digit($_GET['pagina'])
    ? max(1, (int) $_GET['pagina']) : 1;
$totalPaginas = max(1, (int) ceil($totalPedidosFiltrados / $pedidosPorPagina));
$paginaActual = min($paginaActual, $totalPaginas);
$pedidosPagina = array_slice($pedidosFiltrados, ($paginaActual - 1) * $pedidosPorPagina, $pedidosPorPagina);

if (isset($_GET['exportar']) && $_GET['exportar'] === 'csv') {
    $nombreArchivo = 'pedidos-anuma-' . date('Y-m-d') . '.csv';
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $nombreArchivo . '"');
    $salida = fopen('php://output', 'w');
    fprintf($salida, "\xEF\xBB\xBF");
    fputcsv($salida, ['UUID', 'Cliente', 'Fecha', 'Método de pago', 'Total', 'Estado']);
    foreach ($pedidosFiltrados as $pedido) {
        fputcsv($salida, [
            $pedido['order_uuid'], $pedido['cliente'], $pedido['creado_en'],
            $pedido['metodo_pago'] ?: 'No especificado', $pedido['total'], $pedido['estado']
        ]);
    }
    fclose($salida);
    exit();
}

$inicioGrafico = new DateTime('first day of this month -5 months');
$inicioGrafico->setTime(0, 0, 0);
$stmtGrafico = $pdo->prepare("SELECT DATE_FORMAT(creado_en, '%Y-%m') AS periodo,
    COALESCE(SUM(total), 0) AS ingresos
    FROM orders
    WHERE estado IN $estadosFacturables AND creado_en >= ?
    GROUP BY periodo ORDER BY periodo ASC");
$stmtGrafico->execute([$inicioGrafico->format('Y-m-d H:i:s')]);
$ingresosPorMes = [];
foreach ($stmtGrafico->fetchAll() as $fila) {
    $ingresosPorMes[$fila['periodo']] = (float) $fila['ingresos'];
}
$etiquetasGrafico = [];
$valoresGrafico = [];
$meses = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];
for ($indiceMes = 0; $indiceMes < 6; $indiceMes++) {
    $mes = clone $inicioGrafico;
    $mes->modify("+$indiceMes months");
    $periodo = $mes->format('Y-m');
    $etiquetasGrafico[] = ucfirst($meses[(int) $mes->format('n') - 1]) . ' ' . $mes->format('Y');
    $valoresGrafico[] = $ingresosPorMes[$periodo] ?? 0;
}

$stmtProductos = $pdo->prepare("SELECT nombre_producto, SUM(cantidad) AS unidades,
    SUM(subtotal) AS ingresos
    FROM order_items oi
    INNER JOIN orders o ON o.id = oi.order_id
    WHERE o.estado IN $estadosFacturables $filtroFecha
    GROUP BY oi.producto_id, oi.nombre_producto
    ORDER BY unidades DESC, ingresos DESC LIMIT 5");
$stmtProductos->execute($parametrosFecha);
$productosMasVendidos = $stmtProductos->fetchAll();
$tasaNoConcretados = (int) $metricas['total_pedidos'] > 0
    ? ((int) $metricas['pedidos_no_concretados'] / (int) $metricas['total_pedidos']) * 100 : 0;
$parametrosUrl = http_build_query(array_filter(['desde' => $desde, 'hasta' => $hasta], static fn ($valor) => $valor !== ''));
$urlExportar = 'reportes.php' . ($parametrosUrl ? '?' . $parametrosUrl . '&' : '?') . 'exportar=csv';
$urlPagina = static function ($pagina) use ($desde, $hasta) {
    return 'reportes.php?' . http_build_query(array_filter([
        'desde' => $desde, 'hasta' => $hasta, 'pagina' => $pagina
    ], static fn ($valor) => $valor !== ''));
};
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes - ANÜMA</title>
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="css/reportes.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
</head>
<body>
<div class="admin-container">
    <?php include 'sidebar.php'; ?>
    <main class="main-content">
        <header class="admin-header report-header">
            <div>
                <span class="eyebrow">MÉTRICAS Y CRECIMIENTO</span>
                <h1>Reportes</h1>
                <p>Estadísticas de ventas, pedidos procesados y productos más vendidos.</p>
            </div>
            <a class="btn btn-primary export-button" href="<?php echo htmlspecialchars($urlExportar); ?>">
                <i class="fas fa-file-csv"></i> Exportar a CSV
            </a>
        </header>

        <section class="filter-panel" aria-label="Filtros de reportes">
            <form method="get" class="date-form">
                <div class="field"><label for="desde">Desde</label><input type="date" id="desde" name="desde" value="<?php echo htmlspecialchars($desde); ?>"></div>
                <div class="field"><label for="hasta">Hasta</label><input type="date" id="hasta" name="hasta" value="<?php echo htmlspecialchars($hasta); ?>"></div>
                <button type="submit" class="btn btn-primary"><i class="fas fa-filter"></i> Aplicar filtros</button>
                <?php if ($desde || $hasta): ?><a class="clear-filter" href="reportes.php">Limpiar</a><?php endif; ?>
            </form>
            <span class="result-count"><?php echo $totalPedidosFiltrados; ?> pedidos en el rango</span>
        </section>

        <section class="kpi-grid">
            <article class="kpi-card accent-red"><span class="kpi-icon"><i class="fas fa-coins"></i></span><div><p>Total facturado</p><strong>$<?php echo number_format((float) $metricas['facturado_historico'], 2); ?></strong><small>Histórico</small></div></article>
            <article class="kpi-card accent-gold"><span class="kpi-icon"><i class="fas fa-calendar-check"></i></span><div><p>Facturado este mes</p><strong>$<?php echo number_format((float) $metricas['facturado_mes'], 2); ?></strong><small>Mes actual</small></div></article>
            <article class="kpi-card accent-blue"><span class="kpi-icon"><i class="fas fa-receipt"></i></span><div><p>Total de pedidos</p><strong><?php echo number_format((int) $metricas['total_pedidos']); ?></strong><small><?php echo number_format($tasaNoConcretados, 1); ?>% pendientes o cancelados</small></div></article>
            <article class="kpi-card accent-green"><span class="kpi-icon"><i class="fas fa-chart-pie"></i></span><div><p>Ticket promedio</p><strong>$<?php echo number_format((float) $metricas['ticket_promedio'], 2); ?></strong><small>Pedidos pagados o completados</small></div></article>
        </section>

        <section class="report-grid">
            <article class="report-card chart-card"><div class="section-heading"><div><span class="eyebrow">RENDIMIENTO</span><h2>Ingresos de los últimos 6 meses</h2></div><i class="fas fa-chart-line"></i></div><div class="chart-wrapper"><canvas id="ingresosChart"></canvas></div></article>
            <article class="report-card"><div class="section-heading"><div><span class="eyebrow">PRODUCTOS</span><h2>Más vendidos</h2></div><i class="fas fa-star"></i></div>
                <?php if ($productosMasVendidos): ?><ol class="product-ranking"><?php foreach ($productosMasVendidos as $indiceProducto => $producto): ?><li><span class="rank-number"><?php echo $indiceProducto + 1; ?></span><div><strong><?php echo htmlspecialchars($producto['nombre_producto']); ?></strong><small><?php echo number_format((int) $producto['unidades']); ?> unidades</small></div><b>$<?php echo number_format((float) $producto['ingresos'], 2); ?></b></li><?php endforeach; ?></ol><?php else: ?><p class="empty-state">Aún no hay ventas facturables.</p><?php endif; ?>
            </article>
        </section>

        <section class="report-card orders-card"><div class="section-heading"><div><span class="eyebrow">DETALLE</span><h2>Pedidos filtrados</h2></div><i class="fas fa-list"></i></div><div class="table-container"><table class="admin-table"><thead><tr><th>UUID</th><th>Cliente</th><th>Fecha</th><th>Método</th><th>Total</th><th>Estado</th></tr></thead><tbody>
        <?php if ($pedidosFiltrados): foreach ($pedidosPagina as $pedido): ?><tr><td class="uuid-cell"><?php echo htmlspecialchars($pedido['order_uuid']); ?></td><td><?php echo htmlspecialchars($pedido['cliente']); ?></td><td><?php echo date('d/m/Y H:i', strtotime($pedido['creado_en'])); ?></td><td><?php echo htmlspecialchars($pedido['metodo_pago'] ?: 'No especificado'); ?></td><td class="money-cell">$<?php echo number_format((float) $pedido['total'], 2); ?></td><td><span class="status status-<?php echo strtolower($pedido['estado']); ?>"><?php echo htmlspecialchars($pedido['estado']); ?></span></td></tr><?php endforeach; else: ?><tr><td colspan="6" class="empty-state">No hay pedidos para el rango seleccionado.</td></tr><?php endif; ?></tbody></table></div>
            <?php if ($totalPaginas > 1): ?><nav class="pagination" aria-label="Paginación de pedidos"><span class="pagination-summary">Página <?php echo $paginaActual; ?> de <?php echo $totalPaginas; ?></span><div class="pagination-links"><?php if ($paginaActual > 1): ?><a href="<?php echo htmlspecialchars($urlPagina($paginaActual - 1)); ?>" aria-label="Página anterior"><i class="fas fa-chevron-left"></i> Anterior</a><?php endif; ?><?php for ($numeroPagina = 1; $numeroPagina <= $totalPaginas; $numeroPagina++): ?><a class="<?php echo $numeroPagina === $paginaActual ? 'active' : ''; ?>" href="<?php echo htmlspecialchars($urlPagina($numeroPagina)); ?>"><?php echo $numeroPagina; ?></a><?php endfor; ?><?php if ($paginaActual < $totalPaginas): ?><a href="<?php echo htmlspecialchars($urlPagina($paginaActual + 1)); ?>" aria-label="Página siguiente">Siguiente <i class="fas fa-chevron-right"></i></a><?php endif; ?></div></nav><?php endif; ?></section>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>
<script>
new Chart(document.getElementById('ingresosChart'), { type: 'line', data: { labels: <?php echo json_encode($etiquetasGrafico); ?>, datasets: [{ label: 'Ingresos', data: <?php echo json_encode($valoresGrafico); ?>, borderColor: '#b51e35', backgroundColor: 'rgba(181, 30, 53, .12)', fill: true, tension: .35, pointBackgroundColor: '#b51e35', pointRadius: 4 }] }, options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false }, tooltip: { callbacks: { label: context => ' $' + Number(context.raw).toLocaleString('es-EC', { minimumFractionDigits: 2 }) } } }, scales: { y: { beginAtZero: true, ticks: { callback: value => '$' + Number(value).toLocaleString('es-EC') } }, x: { grid: { display: false } } } } });
</script>
</body>
</html>
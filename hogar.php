<?php

include('bases/header.php');
require_once "admin/db/conexion.php"; 

$subcat_filtro = isset($_GET['subcat']) ? strtolower(trim($_GET['subcat'])) : '';
$busqueda = isset($_GET['q']) ? trim($_GET['q']) : '';
$productos_por_pagina = 8;
$pagina_actual = isset($_GET['page']) ? max(1, (int)$_GET['page']) : 1;

$where = ["c.nombre = 'HOGAR'", "p.disponible = 1"];
$params = [];

if ($subcat_filtro !== '') {
    $where[] = "LOWER(COALESCE(p.subcategorias, '')) LIKE :subcat";
    $params[':subcat'] = '%' . $subcat_filtro . '%';
}

if ($busqueda !== '') {
    $where[] = "LOWER(p.nombre) LIKE :busqueda";
    $params[':busqueda'] = '%' . strtolower($busqueda) . '%';
}

$whereSql = implode(' AND ', $where);

$countSql = "SELECT COUNT(*)
    FROM productos p
    LEFT JOIN fotos f ON p.id = f.producto_id AND f.es_perfil = 1
    JOIN categorias c ON p.categoria_id = c.id
    WHERE {$whereSql}";
$countStmt = $pdo->prepare($countSql);
foreach ($params as $key => $value) {
    $countStmt->bindValue($key, $value);
}
$countStmt->execute();
$total_productos = (int) $countStmt->fetchColumn();

$total_paginas = max(1, (int) ceil($total_productos / $productos_por_pagina));
if ($pagina_actual > $total_paginas) {
    $pagina_actual = $total_paginas;
}
$offset = ($pagina_actual - 1) * $productos_por_pagina;

$sql = "SELECT p.*, f.ruta as foto,
        (SELECT SUM(stock) FROM variantes WHERE producto_id = p.id) as suma_stock,
        (SELECT COUNT(*) FROM variantes WHERE producto_id = p.id) as tiene_variantes
        FROM productos p 
        LEFT JOIN fotos f ON p.id = f.producto_id AND f.es_perfil = 1 
        JOIN categorias c ON p.categoria_id = c.id 
        WHERE {$whereSql}
        ORDER BY p.creado_en DESC
        LIMIT :limit OFFSET :offset";
$stmt = $pdo->prepare($sql);
foreach ($params as $key => $value) {
    $stmt->bindValue($key, $value);
}
$stmt->bindValue(':limit', $productos_por_pagina, PDO::PARAM_INT);
$stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
$stmt->execute();
$productos_pagina = $stmt->fetchAll(PDO::FETCH_ASSOC);
$pag_query = ($subcat_filtro !== '' ? '&subcat=' . urlencode($subcat_filtro) : '') . ($busqueda !== '' ? '&q=' . urlencode($busqueda) : '');
?>

<style>
    /* Estructura del layout principal */
    main.container {
        width: 100% !important;
        max-width: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
    }

    .layout {
        display: flex !important;
        width: 100% !important;
        gap: 24px !important;
        padding-right: 24px !important;
        box-sizing: border-box;
    }

    .layout > section {
        flex: 1 !important;
        min-width: 0;
        width: 100% !important;
        padding-top: 24px;
        padding-bottom: 15px;
    }

    /* Product cards específicos de esta página */
    .products-grid {
        display: grid;
        grid-template-columns: repeat(4, minmax(0, 1fr));
        gap: 20px;
        width: 100%;
        max-width: none;
        margin: 0 0 10px 0;
        position: relative;
        left: 0;
        align-items: stretch;
    }
    .producto-card {
        background: #f4f4f4;
        border-radius: 15px;
        padding: 15px;
        text-align: center;
        box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.05);
        transition: transform 0.3s ease;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    .producto-card:hover {
        transform: translateY(-5px);
    }
    .img-container {
        width: 100%;
        aspect-ratio: 3 / 4;
        overflow: hidden;
        border-radius: 10px;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
    }
    .img-container img {
        width: 100%;
        height: 100%;
        object-fit: contain;
        object-position: center;
        background: #f4f4f4;
        transition: transform 0.5s ease;
    }
    .producto-card:hover .img-container img {
        transform: scale(1.05);
    }
    .info-producto h3 {
        font-size: 16px;
        margin: 10px 0 5px;
        color: #333;
        text-transform: capitalize;
    }
    .precio {
        font-size: 1.1rem;
        font-weight: bold;
        margin-bottom: 15px;
        color: #000;
    }
    .acciones {
        display: flex;
        justify-content: space-between;
        gap: 10px;
        margin-top: auto;
    }
    .btn-carrito-temu {
        width: 100%; padding: 10px; background-color: #333; color: white;
        border: none; border-radius: 25px; font-weight: bold; cursor: pointer;
        display: flex; justify-content: center; align-items: center; gap: 8px;
        transition: transform 0.2s, background 0.2s;
    }
    .btn-carrito-temu:hover { background-color: #000; transform: scale(1.05); }
    .btn-carrito.agotado { 
        width: 100%; padding: 10px; border-radius: 25px;
        background-color: #e0e0e0 !important; cursor: not-allowed !important; 
        color: #999 !important; border: 1px solid #d0d0d0 !important; pointer-events: none; 
    }
    .badge-agotado { 
        position: absolute; top: 10px; right: 10px; background-color: #222; color: #fff; 
        padding: 4px 8px; font-size: 0.75rem; font-weight: 600; border-radius: 4px; z-index: 2; 
    }
    .category-rail {
        width: 100%;
        max-width: none;
        margin: 0 0 18px 0;
        position: relative;
        left: 0;
    }
    .subcategories-row {
        display: flex;
        align-items: center;
        gap: 10px;
        flex-wrap: wrap;
        margin: 0;
        width: 100%;
        max-width: none;
        padding: 0;
        box-sizing: border-box;
    }
    .subcategory-pill {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 8px 12px;
        border-radius: 999px;
        background: #fff;
        border: 1px solid #d8b995;
        color: #442D1C;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
    }
    .subcategory-pill:hover {
        background: #f7e9cf;
    }
    .subcategory-pill.active {
        background: #e8d1a8;
        border-color: #442D1C;
        box-shadow: 0 2px 6px rgba(68, 45, 28, 0.2);
    }
    .section-title {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin: 18px 0 18px 0;
        width: 100%;
        max-width: none;
        position: relative;
        left: 0;
        padding: 0;
        box-sizing: border-box;
    }
    .section-title h3 { margin: 0; color: var(--cafe); font-size: 24px; }
    .pagination { display: flex; justify-content: center; gap: 8px; flex-wrap: wrap; margin: 10px auto 10px auto; width: 100%; }
    .pagination a, .pagination span { display: inline-flex; align-items: center; justify-content: center; min-width: 38px; padding: 8px 12px; border-radius: 999px; background: #fff; border: 1px solid #d8b995; color: #442D1C; text-decoration: none; font-size: 14px; font-weight: 600; }
    .pagination a:hover { background: #f7e9cf; }
    .pagination .page-current { background: #442D1C; color: #fff; border-color: #442D1C; }

    @media (max-width: 1000px) {
        .products-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
    }

    @media (max-width: 600px) {
        .layout { padding-right: 12px; gap: 12px; }
        .products-grid { grid-template-columns: 1fr; }
        .section-title h3 { font-size: 28px; }
    }
</style>

<main class="container">
    <!-- Layout: Sidebar + Content -->
    <div class="layout">
        <?php include 'sidebar.php'; ?>

        <section>
            <?php include 'ofertas.php'; ?>

            <div class="category-rail">
                <div class="section-title">
                    <h3>Hogar</h3>
                </div>
                <div class="subcategories-row">
                    <a class="subcategory-pill <?php echo $subcat_filtro === '' ? 'active' : ''; ?>" href="hogar.php">Todo</a>
                    <a class="subcategory-pill <?php echo $subcat_filtro === 'sala' ? 'active' : ''; ?>" href="hogar.php?subcat=sala">Sala</a>
                    <a class="subcategory-pill <?php echo $subcat_filtro === 'cocina' ? 'active' : ''; ?>" href="hogar.php?subcat=cocina">Cocina</a>
                    <a class="subcategory-pill <?php echo $subcat_filtro === 'bano' ? 'active' : ''; ?>" href="hogar.php?subcat=bano">Baño</a>
                </div>
            </div>
            <?php if (empty($productos_pagina)): ?>
                <div style="width: 100%; margin: 0 auto 24px auto; padding: 20px; background: #fff; border-radius: 12px; text-align: center; color: #666;">
                    No se encontraron productos para esta búsqueda en esta categoría.
                </div>
            <?php else: ?>
            <div class="products-grid">
                <?php foreach ($productos_pagina as $prod): 
                    if ($prod['tiene_variantes'] > 0) {
                        $stock_real = intval($prod['suma_stock']);
                    } else {
                        $stock_real = intval($prod['stock_total']);
                    }
                ?>
                    <div class="producto-card">
                        <a href="producto_detalle.php?slug=<?php echo $prod['slug']; ?>" class="img-container">
                            <img src="<?php echo !empty($prod['foto']) ? $prod['foto'] : 'style/img/placeholder.png'; ?>" 
                                 alt="<?php echo htmlspecialchars($prod['nombre']); ?>">
                            
                            <?php if ($stock_real <= 0): ?>
                                <span class="badge-agotado">Agotado</span>
                            <?php endif; ?>
                        </a>
                        
                        <div class="info-producto">
                            <h3><?php echo htmlspecialchars($prod['nombre']); ?></h3>
                            <p class="precio">$<?php echo number_format($prod['precio'], 2); ?></p>
                            
                            <div class="acciones">
                                <?php if ($stock_real > 0): ?>
                                    <button class="btn-carrito-temu" onclick="abrirModal('<?php echo $prod['id']; ?>')">
                                        <i class="fas fa-cart-plus"></i> Añadir
                                    </button>
                                <?php else: ?>
                                    <button class="btn-carrito agotado" disabled>Agotado</button>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
            <?php endif; ?>

            <?php if ($total_paginas > 1): ?>
                <div class="pagination">
                    <?php if ($pagina_actual > 1): ?>
                        <a href="hogar.php?page=<?php echo max(1, $pagina_actual - 1); ?><?php echo $pag_query; ?>">«</a>
                    <?php endif; ?>
                    <?php
                        $pages = [];
                        if ($total_paginas <= 7) {
                            $pages = range(1, $total_paginas);
                        } else {
                            $pages[] = 1;
                            if ($pagina_actual > 4) {
                                $pages[] = '...';
                            }
                            $start = max(2, $pagina_actual - 2);
                            $end = min($total_paginas - 1, $pagina_actual + 2);
                            for ($i = $start; $i <= $end; $i++) {
                                $pages[] = $i;
                            }
                            if ($pagina_actual < $total_paginas - 3) {
                                $pages[] = '...';
                            }
                            $pages[] = $total_paginas;
                        }
                        foreach ($pages as $p):
                            if ($p === '...'): ?>
                                <span>...</span>
                            <?php elseif ($p == $pagina_actual): ?>
                                <span class="page-current"><?php echo $p; ?></span>
                            <?php else: ?>
                                <a href="hogar.php?page=<?php echo $p; ?><?php echo $pag_query; ?>"><?php echo $p; ?></a>
                            <?php endif;
                        endforeach;
                    ?>
                    <?php if ($pagina_actual < $total_paginas): ?>
                        <a href="hogar.php?page=<?php echo min($total_paginas, $pagina_actual + 1); ?><?php echo $pag_query; ?>">»</a>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </section>
    </div>
</main>

<?php include('bases/modal_compra.php'); ?>
<?php include('bases/footer.php'); ?>
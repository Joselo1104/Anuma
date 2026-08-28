<?php
// parcial: ofertas.php
// Muestra un banner de oferta reutilizable con contenido configurable desde admin/Aofertas.php
require_once __DIR__ . '/admin/db/conexion.php';

$stmt = $pdo->query("SELECT clave, valor FROM configuracion WHERE clave IN ('offer_text', 'offer_image')");
$config_data = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);

$offer_text = $config_data['offer_text'] ?? 'Descubre descuentos exclusivos en artículos seleccionados. ¡Solo por tiempo limitado!';
$offer_image = $config_data['offer_image'] ?? '';
?>

<style>
    .offer-banner { height:420px; border-radius:14px; overflow:hidden; margin:36px 0 24px; width:100%; max-width:100%; flex:1 1 auto; min-width:0; box-sizing:border-box; display:flex; box-shadow: 0 6px 20px rgba(0,0,0,0.08); }
    .offer-left { width:50%; flex:1 1 50%; min-width:0; display:flex; align-items:center; padding:40px; box-sizing:border-box; }
    .offer-right { width:50%; flex:1 1 50%; min-width:0; background-size:contain; background-position:center center; background-repeat:no-repeat; display:flex; align-items:center; justify-content:center; background-color: var(--ocre); height:100%; }
    .offer-left .content { max-width:520px; }
    .offer-left h2 { font-size:34px; margin:0 0 12px 0; font-weight:800; color: var(--cafe); }
    .offer-left p { margin:0 0 18px 0; font-size:18px; color: rgba(0,0,0,0.75); }
    .offer-left .btn-primary { background:var(--terracota); color:#fff; padding:12px 20px; border-radius:10px; text-decoration:none; display:inline-block; }
    @media (max-width:1000px){ .offer-banner{flex-direction:column; height:auto;} .offer-left, .offer-right{width:100%;} .offer-right{height:240px;} .offer-left{padding:20px;} }
</style>

<div class="offer-banner" role="region" aria-label="Oferta">
    <div class="offer-left" style="background: var(--ocre);">
        <div class="content">
            <h2>Ofertas especiales</h2>
            <p><?php echo nl2br(htmlspecialchars($offer_text)); ?></p>
        </div>
    </div>
    <div class="offer-right" style="background-image: url('<?php echo htmlspecialchars($offer_image ?: 'style/img/placeholder.png'); ?>');"></div>
</div>

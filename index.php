<?php
require_once 'admin/db/conexion.php';
include('bases/header.php');

// --- DATOS EXISTENTES (BANNERS / CONFIG / FUNCIONES) ---
$stmt_banners = $pdo->query("SELECT ruta FROM fotos WHERE tipo = 'BANNER' AND activo = 1 ORDER BY creado_en DESC LIMIT 6");
$banners = $stmt_banners->fetchAll(PDO::FETCH_ASSOC);

$stmt_config = $pdo->query("SELECT clave, valor FROM configuracion WHERE clave IN ('about_us_text', 'about_us_image')");
$config_data = $stmt_config->fetchAll(PDO::FETCH_KEY_PAIR);
$about_text = $config_data['about_us_text'] ?? 'Texto de "Nosotros" no configurado.';
$about_image = $config_data['about_us_image'] ?? 'uploads/site/default_about.png';

function obtenerProductosPorCategoria($pdo, $nombreCategoria, $limit = 8) {
    $sql = "SELECT p.*, f.ruta as foto,
            (SELECT SUM(stock) FROM variantes WHERE producto_id = p.id) as suma_stock,
            (SELECT COUNT(*) FROM variantes WHERE producto_id = p.id) as tiene_variantes
            FROM productos p 
            LEFT JOIN fotos f ON p.id = f.producto_id AND f.es_perfil = 1 
            JOIN categorias c ON p.categoria_id = c.id 
            WHERE c.nombre = ? AND p.disponible = 1
            ORDER BY p.creado_en DESC LIMIT ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$nombreCategoria, (int)$limit]);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

$ropaProductos = obtenerProductosPorCategoria($pdo, 'ROPA', 8);
$hogarProductos = obtenerProductosPorCategoria($pdo, 'HOGAR', 8);
$papeleriaProductos = obtenerProductosPorCategoria($pdo, 'PAPELERIA', 8);

// --- HILO PRINCIPAL DE LA PÁGINA ---
?>

<!-- Fuentes y estilo específicos de la página ANUMA -->
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;900&display=swap" rel="stylesheet">

<style>
    :root{
        --cafe:#442D1C; --terracota:#740315; --arena:#FAF1E0; --ocre:#E8D1A8; --max-w:1300px;
        --btn-h:54px; --radius:12px; --gap:22px;
    }
    body { background: var(--arena); font-family: 'TT Rounds Neue', Inter, system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; color:var(--cafe); }
    main.container { width:100% !important; max-width:100% !important; margin:0 !important; padding:0 !important; }

    /* Header hero brand */
    .anuma-header { display:flex; align-items:center; justify-content:space-between; gap:20px; margin-bottom:28px; }
    .anuma-brand { display:flex; align-items:center; gap:18px; }
    .anuma-logo { font-weight:900; font-size:28px; letter-spacing:2px; color:var(--cafe); }
    .anuma-sub { color:var(--cafe); opacity:0.8; font-size:13px; }

    /* Search + icons */
    .anuma-search { flex:1; max-width:720px; margin:0 24px; }
    .search-bar { display:flex; align-items:center; gap:8px; background:white; padding:6px; border-radius:10px; border:1px solid var(--ocre); }
    .search-bar input { flex:1; border:0; padding:12px 14px; font-size:16px; outline:none; }
    .search-bar button { background:var(--terracota); color:white; border:0; padding:12px 20px; height:var(--btn-h); border-radius:10px; cursor:pointer; font-weight:600; }

    .icons { display:flex; gap:12px; align-items:center; }
    .icon-btn { background:white; border-radius:10px; padding:10px 12px; border:1px solid var(--ocre); height:48px; display:flex; align-items:center; gap:8px; cursor:pointer; }
    .icon-btn .count { background:var(--terracota); color:white; padding:3px 7px; border-radius:12px; font-size:12px; }

    /* Layout */
    .layout { display:flex !important; width:100% !important; gap:24px !important; padding-right:24px !important; box-sizing:border-box; margin-bottom:0; }
    .layout > section { flex:1 !important; min-width:0; width:100% !important; padding-top:24px; box-sizing:border-box; }
    .sidebar { background:#743015; padding:18px; border-radius:12px; position:sticky; top:28px; height:fit-content; margin-bottom:0; }
    .sidebar h4 { margin:0 0 12px 0; color:#FAF1E0; font-size:18px; font-weight:700; letter-spacing:0.01em; }
    .sidebar a { display:block; padding:10px; color:#FAF1E0; border-radius:8px; text-decoration:none; margin-bottom:6px; font-weight:600; font-size:15px; }
    .sidebar a:hover { background:rgba(255,241,224,0.15); }
    .sidebar a.active { background: rgba(250,241,224,0.92); color: var(--cafe); box-shadow: inset 0 0 0 1px rgba(68, 45, 28, 0.15); }

    .hero-slider { position:relative; height:420px; border-radius:14px; overflow:hidden; width:100% !important; max-width:100% !important; margin:36px 0 24px; }
    .hero-slider .slider-container { position:relative; width:100%; height:100%; }
    .hero-slider .slide { position:absolute; inset:0; opacity:0; transition: opacity 0.8s ease-in-out; background-size:auto 100%; background-position:right center; background-repeat:no-repeat; background-color: var(--ocre); }
    .hero-slider .slide.active { opacity:1; }
    .hero-slider .slide::before { content:''; position:absolute; inset:0; background:linear-gradient(180deg, rgba(68,45,28,0.45), rgba(68,45,28,0.0)); pointer-events:none; }
    /* Contenido a la izquierda, imagen alineada a la derecha */
    .hero-slider .inner { position:relative; z-index:1; width:45%; max-width:620px; padding:40px 20px; display:flex; flex-direction:column; justify-content:center; align-items:flex-start; text-align:left; height:100%; }
    .hero-slider h1 { font-size:44px; margin:0 0 12px 0; font-weight:800; color:#fff; letter-spacing:1px; }
    .hero-slider p { margin:0 0 18px 0; font-size:18px; color:#fffdf7; }
    .hero-slider .cta { display:flex; gap:12px; flex-wrap:wrap; }
    .hero-slider .slider-dots { position:absolute; bottom:18px; left:50%; transform:translateX(-50%); display:flex; gap:10px; z-index:2; }
    .hero-slider .dot { width:12px; height:12px; background:rgba(255,255,255,0.55); border-radius:50%; border:none; cursor:pointer; transition: transform 0.2s ease, background-color 0.2s ease; }
    .hero-slider .dot.active { background:white; transform:scale(1.2); }
    .btn-primary { background:var(--terracota); color:white; border:0; padding:14px 26px; border-radius:12px; font-weight:700; height:var(--btn-h); cursor:pointer; }
    .btn-ghost { background:transparent; border:2px solid rgba(255,255,255,0.3); color:white; padding:12px 22px; border-radius:12px; height:var(--btn-h); }

    /* Product grid */
    .products-grid { display:grid; grid-template-columns: repeat(4,1fr); gap:20px; }
    .section-title { display:flex; justify-content:space-between; align-items:end; margin:18px 0; }
    .section-title h3{ margin:0; color:var(--cafe); }

    /* About */
    .about { background:var(--ocre); padding:22px; border-radius:12px; display:flex; gap:20px; align-items:center; margin-top:28px; width:100%; margin-left:0; margin-right:0; }
    .about img{ width:220px; border-radius:8px; object-fit:cover; }

    @media (max-width: 1024px){ .hero-slider{height:320px; margin:24px 0;} .about { flex-direction: column; text-align: center; } .products-grid{ grid-template-columns: repeat(3, 1fr); } }
    @media (max-width: 768px){
        .layout { flex-direction: column !important; gap: 12px !important; padding-right: 0 !important; }
        .layout > section { width: 100% !important; padding-top: 0; }
        .products-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 12px; }
        .hero-slider { height: 320px; }
        .hero-slider .inner { width: 100%; padding: 24px 16px; }
        .hero-slider h1 { font-size: 32px; }
        .hero-slider p { font-size: 16px; }
        .btn-primary, .btn-ghost { height: 48px; padding: 10px 16px; }
        .about { padding: 16px; }
    }
    @media (max-width: 600px){
        .hero-slider .slide { background-size:cover; background-position:center; }
        .hero-slider .inner { width:100%; padding:20px; }
        .about { padding:18px; }
    }
    @media (max-width:600px){ .anuma-logo{ font-size:22px;} .search-bar button{height:48px;} }
</style>

<main class="container">

  

    <!-- Layout: Sidebar + Content -->
    <div class="layout">
        <?php include 'sidebar.php'; ?>

        <section>
            <div class="hero-slider" role="region" aria-label="Hero ANUMA">
                <div class="slider-container">
                    <?php if (!empty($banners)): ?>
                        <?php foreach ($banners as $index => $banner): ?>
                            <div class="slide<?php echo $index === 0 ? ' active' : ''; ?>" style="background-image:url('<?php echo htmlspecialchars($banner['ruta']); ?>');">
                                <div class="inner">
                                    <h1>Diseños con alma y corazón artesanal</h1>
                                    <p>Explora piezas seleccionadas por su calidad, historia y propósito. Cada producto cuenta una historia.</p>
                                    
                                </div>
                            </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <div class="slide active" style="background-image:url('style/img/placeholder.png');">
                            <div class="inner">
                                <h1>Diseños con alma y corazón artesanal</h1>
                                <p>Explora piezas seleccionadas por su calidad, historia y propósito. Cada producto cuenta una historia.</p>
                                <div class="cta">
                                    <a href="ropa_accesorio.php" class="btn-primary">Ver Colección</a>
                                    <a href="hogar.php" class="btn-ghost">Explorar Hogar</a>
                                </div>
                            </div>
                        </div>
                    <?php endif; ?>
                </div>
                <?php if (count($banners) > 1): ?>
                    <div class="slider-dots">
                        <?php foreach ($banners as $index => $banner): ?>
                            <button class="dot<?php echo $index === 0 ? ' active' : ''; ?>" type="button" aria-label="Ver banner <?php echo $index + 1; ?>"></button>
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>
            </div>


            <!-- About -->
            <div class="about">
                <div style="flex:1;">
                    <h3>Acerca de ANUMA</h3>
                    <p style="margin-top:8px; color:var(--cafe); opacity:0.9;">
                        <?php echo htmlspecialchars($about_text); ?>
                    </p>
                </div>
                <div>
                    <img src="<?php echo htmlspecialchars($about_image); ?>" alt="Sobre ANUMA">
                </div>
            </div>

        </section>
    </div>

</main>

<!-- Scripts: simple enhancements (keep existing carousel script) -->
<script>
// Simple accessibility: focus outline when keyboard navigating
document.body.addEventListener('keydown', function(e){ if(e.key==='Tab') document.body.classList.add('show-focus'); });
// Carrusel de banners
document.addEventListener('DOMContentLoaded', function() {
    var slides = document.querySelectorAll('.hero-slider .slide');
    var dots = document.querySelectorAll('.hero-slider .dot');
    if (!slides.length) return;

    var currentIndex = 0;
    var intervalTime = 7000;
    var intervalId;

    function goToSlide(index) {
        slides[currentIndex].classList.remove('active');
        if (dots[currentIndex]) dots[currentIndex].classList.remove('active');
        currentIndex = (index + slides.length) % slides.length;
        slides[currentIndex].classList.add('active');
        if (dots[currentIndex]) dots[currentIndex].classList.add('active');
    }

    function nextSlide() {
        goToSlide(currentIndex + 1);
    }

    if (dots.length) {
        dots.forEach(function(dot, index) {
            dot.addEventListener('click', function() {
                goToSlide(index);
                resetInterval();
            });
        });
    }

    function resetInterval() {
        clearInterval(intervalId);
        intervalId = setInterval(nextSlide, intervalTime);
    }

    intervalId = setInterval(nextSlide, intervalTime);
});
</script>

<?php include('bases/footer.php'); ?>

<?php
// 1. DETECCIÓN DE RUTAS (SISTEMA DE NIVELES)
$nivel = (strpos($_SERVER['PHP_SELF'], '/usuario/') !== false) ? '../' : './';

// 2. CONTROL DE SESIÓN
if (session_status() === PHP_SESSION_NONE) {
    if (file_exists(__DIR__ . '/config_sesion.php')) {
        require_once __DIR__ . '/config_sesion.php';
    } else {
        session_start();
    }
}

// 3. LÓGICA DE TIMEOUT
$tiempo_limite = 1800; 
if (isset($_SESSION['user_id'])) {
    if (isset($_SESSION['ultimo_acceso'])) {
        $tiempo_transcurrido = time() - $_SESSION['ultimo_acceso'];
        if ($tiempo_transcurrido > $tiempo_limite) {
            session_unset(); session_destroy();
            header("Location: " . $nivel . "usuario/login.php?error=timeout");
            exit();
        }
    }
    $_SESSION['ultimo_acceso'] = time();
}

$pagina_actual = basename($_SERVER['SCRIPT_NAME']);

// CALCULAR TOTAL REAL DEL CARRITO
$total_articulos_header = 0;
if (isset($_SESSION['carrito']) && !empty($_SESSION['carrito'])) {
    foreach ($_SESSION['carrito'] as $item) {
        $total_articulos_header += $item['cantidad'];
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ANUMA - Artesanía y Diseño</title>
    <link rel="stylesheet" href="<?php echo $nivel; ?>style/css/main-style.css?v=<?php echo time(); ?>">
    <link rel="stylesheet" href="<?php echo $nivel; ?>style/css/footer.css?v=<?php echo time(); ?>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    
    <style>
        :root {
            --cafe: #442D1C;
            --terracota: #743015;
            --arena: #FAF1E0;
            --ocre: #E8D1A8;
            --blanco: #FFFFFF;
            --alto: 80px;
            --franja-h: 45px;
        }

        html, body {
            background: #FAF1E0 !important;
            margin: 0;
            padding: 0;
            font-family: 'TT Rounds Neue', Inter, system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            color: var(--cafe);
            overflow-x: hidden;
        }

        /* HEADER EN ESCRITORIO */
        header.site-header {
            background: var(--arena);
            height: var(--alto);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            z-index: 100;
        }

        .header-inner {
            width: min(1200px, calc(100% - 40px));
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            height: 100%;
        }

        .header-center {
            text-align: center;
        }

        .brand-logo {
            max-height: 55px;
            width: auto;
            display: block;
            transform: scale(0.9);
            transform-origin: center center;
        }

        .header-left, .header-right {
            display: flex;
            align-items: center;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
        }

        .header-left { left: 0; }
        .header-right { right: 0; }

        .action-links {
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .action-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 9px 15px;
            border-radius: 999px;
            border: 1px solid rgba(68,45,28,0.14);
            background: rgba(255,255,255,0.95);
            color: var(--cafe);
            font-size: 14px;
            text-decoration: none;
            font-weight: 700;
        }

        .action-button:hover {
            background: var(--ocre);
        }

        .cart-button {
            position: relative;
        }

        .cart-count {
            position: absolute;
            top: -6px;
            right: -6px;
            min-width: 20px;
            height: 20px;
            border-radius: 999px;
            background: var(--terracota);
            color: #fff;
            font-size: 11px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
        }

        /* Franja café en escritorio */
        .header-strip {
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            height: var(--franja-h);
            background: #442D1C;
            z-index: 10;
            display: flex;
            align-items: center;
            padding: 0 14px;
            box-sizing: border-box;
        }

        .strip-search {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #fff;
            border-radius: 999px;
            padding: 3px 10px;
            height: 30px;
            min-width: 150px;
            max-width: 220px;
            width: 220px;
            border: 1px solid rgba(0,0,0,0.08);
            box-sizing: border-box;
        }

        .strip-search i { color: #442D1C; font-size: 12px; }
        .strip-search input { border: none; outline: none; background: transparent; width: 100%; font-size: 12px; color: #442D1C; }

        /* ========================================================== */
        /* REGLAS RESPONSIVAS PARA MÓVIL (< 768px)                     */
        /* ========================================================== */
        @media (max-width: 1024px) {
            header,
            header.site-header {
                position: static !important;
                height: auto !important;
                min-height: unset !important;
                max-height: none !important;
                display: flex !important;
                flex-direction: column !important;
                width: 100% !important;
                padding: 10px 0 0 0 !important;
                margin: 0 !important;
                box-shadow: none !important;
                background: #FAF1E0 !important;
            }

            .header-inner {
                position: static !important;
                width: 100% !important;
                height: auto !important;
                display: flex !important;
                flex-direction: column !important;
                align-items: center !important;
                gap: 8px !important;
                padding: 0 12px 10px 12px !important;
                box-sizing: border-box !important;
            }

            /* 1. Logo centrado */
            .header-center {
                position: static !important;
                margin: 0 auto !important;
            }

            .brand-logo {
                max-height: 40px !important;
                transform: scale(0.9);
                transform-origin: center;
            }

            /* 2. Fila de botones (Home, Cuenta, Pedidos, Carrito) */
            .header-nav-row {
                position: static !important;
                width: 100% !important;
                display: flex !important;
                justify-content: space-between !important;
                align-items: center !important;
                gap: 6px !important;
            }

            .header-left,
            .header-right {
                position: static !important;
                transform: none !important;
                top: auto !important;
                left: auto !important;
                right: auto !important;
                display: flex !important;
                width: auto !important;
            }

            .action-links {
                gap: 6px !important;
                flex-wrap: nowrap !important;
            }

            .action-button {
                padding: 6px 10px !important;
                font-size: 12px !important;
            }

            /* 3. Franja del buscador apilada debajo */
            .header-strip {
                position: static !important;
                top: auto !important;
                left: auto !important;
                width: 100% !important;
                height: 48px !important;
                display: flex !important;
                justify-content: center !important;
                align-items: center !important;
                background: #442D1C !important;
                padding: 0 12px !important;
                box-sizing: border-box !important;
                margin: 0 !important;
            }

            .strip-search {
                width: 100% !important;
                max-width: 100% !important;
                min-width: 0 !important;
                height: 32px !important;
            }

            /* 4. Cuerpo principal arranca en orden vertical */
            main,
            main.container {
                position: static !important;
                margin-top: 10px !important;
                padding: 0 12px !important;
                width: 100% !important;
                max-width: 100% !important;
                box-sizing: border-box !important;
            }

            .layout {
                position: static !important;
                display: flex !important;
                flex-direction: column !important;
                gap: 12px !important;
                width: 100% !important;
                padding: 0 !important;
                margin: 0 !important;
            }

            /* 5. Carrusel horizontal de categorías */
            .sidebar-wrapper {
                position: static !important;
                width: 100% !important;
                min-width: 100% !important;
                background: transparent !important;
                margin: 0 !important;
                padding: 0 !important;
            }

            .sidebar-wrapper .sidebar,
            .sidebar {
                position: static !important;
                top: auto !important;
                display: flex !important;
                flex-direction: row !important;
                flex-wrap: nowrap !important;
                overflow-x: auto !important;
                width: 100% !important;
                box-sizing: border-box !important;
                padding: 8px 10px !important;
                gap: 8px !important;
                background-color: var(--terracota, #743015) !important;
                border-radius: 10px !important;
                -webkit-overflow-scrolling: touch;
            }

            .sidebar h4,
            .sidebar hr {
                display: none !important;
            }

            .sidebar a {
                flex-shrink: 0 !important;
                white-space: nowrap !important;
                margin: 0 !important;
                padding: 6px 12px !important;
                font-size: 13px !important;
            }

            .layout > section {
                width: 100% !important;
                padding-top: 0 !important;
            }
        }
    </style>
</head>
<body>

    <header class="site-header">
        <div class="header-inner">
            <div class="header-center">
                <a href="<?php echo $nivel; ?>index.php" class="brand-link" aria-label="Ir a ANUMA">
                    <img src="<?php echo $nivel; ?>style/img/logo.png?v=<?php echo time(); ?>" alt="Logotipo ANÜMA" class="brand-logo">
                </a>
            </div>

            <div class="header-nav-row">
                <div class="header-left">
                    <div class="action-links">
                        <a href="<?php echo $nivel; ?>index.php" class="action-button" title="Ir al inicio">
                            <i class="fas fa-home"></i>
                        </a>
                    </div>
                </div>

                <div class="header-right">
                    <div class="action-links">
                        <?php if (!isset($_SESSION['user_id'])): ?>
                            <a href="<?php echo $nivel; ?>usuario/login.php" class="action-button">Iniciar Sesión</a>
                        <?php else: ?>
                            <a href="<?php echo $nivel; ?>usuario/perfil.php" class="action-button">Mi Cuenta</a>
                            <a href="<?php echo $nivel; ?>mis_pedidos.php" class="action-button">Mis pedidos</a>
                        <?php endif; ?>
                        <a href="<?php echo $nivel; ?>carrito.php" class="action-button cart-button">
                            <i class="fas fa-shopping-cart"></i>
                            <span class="cart-count"><?php echo $total_articulos_header; ?></span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="header-strip" aria-hidden="false">
            <form class="strip-search" action="<?php echo $nivel . $pagina_actual; ?>" method="get" role="search" aria-label="Buscar productos">
                <i class="fas fa-search" aria-hidden="true"></i>
                <input type="text" name="q" placeholder="Buscar..." value="<?php echo htmlspecialchars(isset($_GET['q']) ? $_GET['q'] : ''); ?>">
                <?php if (isset($_GET['subcat']) && trim($_GET['subcat']) !== ''): ?>
                    <input type="hidden" name="subcat" value="<?php echo htmlspecialchars(trim($_GET['subcat'])); ?>">
                <?php endif; ?>
                <input type="hidden" name="page" value="1">
            </form>
        </div>
    </header>
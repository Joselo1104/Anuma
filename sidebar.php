<?php
// Componente reutilizable del sidebar ANUMA.
// Incluye estilos y menú para usar en varias páginas.
$current_page = basename($_SERVER['PHP_SELF']);
?>

<style>
    :root {
        --cafe: #442D1C;
        --terracota: #743015;
        --arena: #FAF1E0;
        --ocre: #E8D1A8;
        --sidebar-w: 180px;
        --gap: 24px;
    }

    /* Contenedor principal de 2 columnas */
    .layout {
        display: flex;
        gap: var(--gap);
        align-items: stretch !important; /* Ambas columnas tienen la misma altura */
        position: relative;
        margin: 0 !important;
        padding: 0 !important;
        padding-right: var(--gap) !important;
        width: 100%;
        box-sizing: border-box;
    }

    /* 1. Columna del Sidebar: Fondo continuo hasta el footer */
    .sidebar-wrapper {
        width: var(--sidebar-w);
        min-width: var(--sidebar-w);
        background-color: var(--terracota);
        align-self: stretch;
        flex-shrink: 0;
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    /* 2. Menú interior Sticky: Se fija al hacer scroll sin cortar el fondo */
    .sidebar-wrapper .sidebar {
        position: sticky;
        top: 0;
        width: 100%;
        box-sizing: border-box;
        padding: 55px 16px 16px;
        background: transparent; /* El fondo lo proporciona .sidebar-wrapper */
        z-index: 2;
    }

    .sidebar h4 {
        margin: 0 0 16px 0;
        color: #FAF1E0;
        font-size: 18px;
        font-weight: 700;
        letter-spacing: 0.01em;
    }

    .sidebar a {
        display: block;
        padding: 10px 12px;
        color: #FAF1E0;
        border-radius: 8px;
        text-decoration: none;
        margin-bottom: 6px;
        font-weight: 600;
        font-size: 14px;
        transition: background 0.2s ease, color 0.2s ease;
    }

    .sidebar a:hover {
        background: rgba(250, 241, 224, 0.15);
    }

    .sidebar a.active {
        background: rgba(250, 241, 224, 0.92);
        color: var(--cafe);
        box-shadow: inset 0 0 0 1px rgba(68, 45, 28, 0.15);
    }

    /* Sección derecha del contenido */
    .layout > section {
        flex: 1;
        min-width: 0;
        padding-top: 24px;
        padding-bottom: 40px;
        box-sizing: border-box;
    }

    @media (max-width: 1024px) {
        .layout {
            display: flex;
            flex-direction: column;
            padding-right: 0 !important;
        }
        .sidebar-wrapper {
            width: 100%;
            min-width: 100%;
        }
        .sidebar-wrapper .sidebar {
            position: static;
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: nowrap;
            overflow-x: auto;
            overflow-y: hidden;
            padding: 8px 10px;
        }
        .sidebar-wrapper .sidebar h4,
        .sidebar-wrapper .sidebar hr {
            display: none;
        }
        .sidebar-wrapper .sidebar a {
            flex: 0 0 auto;
            white-space: nowrap;
            margin-bottom: 0;
        }
    }
</style>

<div class="sidebar-wrapper">
    <aside class="sidebar">
        <h4>Categorías</h4>
        <a href="index.php" class="<?php echo $current_page === 'index.php' ? 'active' : ''; ?>">Portada</a>
        <a href="hogar.php" class="<?php echo $current_page === 'hogar.php' ? 'active' : ''; ?>">Hogar</a>
        <a href="ropa_accesorio.php" class="<?php echo $current_page === 'ropa_accesorio.php' ? 'active' : ''; ?>">Vestimenta</a>
        <a href="papeleria.php" class="<?php echo $current_page === 'papeleria.php' ? 'active' : ''; ?>">Materiales de Oficina</a>
        <a href="accesorios.php" class="<?php echo $current_page === 'accesorios.php' ? 'active' : ''; ?>">Accesorios</a>

        <hr style="border:none; margin:14px 0; border-top:1px solid rgba(250,241,224,0.35);">
        <a href="contacto.php" class="<?php echo $current_page === 'contacto.php' ? 'active' : ''; ?>">Sobre nosotros</a>
    </aside>
</div>
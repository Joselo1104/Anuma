<?php
session_start();
if (!isset($_SESSION['admin_id'])) {
    header("Location: Alogin.php");
    exit();
}
require_once "db/conexion.php";

$stmt = $pdo->query("SELECT clave, valor FROM configuracion WHERE clave IN ('offer_text', 'offer_image')");
$config_data = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);

$offer_text = $config_data['offer_text'] ?? '';
$offer_image = $config_data['offer_image'] ?? '';
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Configuración de Ofertas - USGP</title>
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="css/configuracion.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
</head>
<body>
<div class="admin-container">
    <?php include 'sidebar.php'; ?>
    <main class="main-content">
        <header class="admin-header">
            <h1>Ofertas</h1>
            <p>Configura el texto y la imagen que aparecerán en el banner de ofertas.</p>
        </header>

        <?php if(isset($_GET['error'])): ?>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                <?php echo htmlspecialchars(urldecode($_GET['error'])); ?>
            </div>
        <?php endif; ?>
        <?php if(isset($_GET['exito'])): ?>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <?php echo htmlspecialchars($_GET['exito']); ?>
            </div>
        <?php endif; ?>

        <form action="Aacciones_config.php" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="accion" value="guardar_ofertas">
            <div class="config-grid">
                <div class="card">
                    <div class="card-header">
                        <h3><i class="fas fa-edit"></i> Editar Oferta</h3>
                    </div>
                    <div class="form-group">
                        <label for="offer_text" class="form-label">Texto de la sección de Ofertas</label>
                        <textarea name="offer_text" id="offer_text" class="form-control" placeholder="Escribe el texto para el banner de ofertas..."><?php echo htmlspecialchars($offer_text); ?></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Imagen del banner de Ofertas</label>
                        <div class="file-upload-wrapper">
                            <i class="fas fa-cloud-upload-alt upload-icon"></i>
                            <div class="upload-text">Arrastra una imagen aquí o haz clic para seleccionar</div>
                            <div style="font-size: 0.8em; color: #999; margin-top: 5px;">Formatos: JPG, PNG, WebP (Máx 3MB)</div>
                            <input type="file" name="offer_image" accept="image/jpeg,image/png,image/webp" onchange="previewImage(this, 'imgPreviewOffer')">
                        </div>
                    </div>
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Guardar Cambios</button>
                        <button type="submit" form="form-eliminar" class="btn btn-danger" onclick="return confirm('¿Seguro que deseas eliminar el texto de ofertas?');"><i class="fas fa-trash-alt"></i> Borrar Texto</button>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <div>
                            <h3><i class="fas fa-eye"></i> Vista Previa</h3>
                            <span class="header-subtitle"><i class="fas fa-search-plus"></i> Vista previa de la oferta</span>
                        </div>
                    </div>
                    <div class="preview-container">
                        <div class="preview-image-box">
                            <img id="imgPreviewOffer" src="../<?php echo htmlspecialchars($offer_image ?: 'style/img/placeholder.png'); ?>?v=<?php echo time(); ?>" alt="Vista previa Ofertas">
                        </div>
                        <div class="preview-content">
                            <div class="preview-title">Banner de Ofertas</div>
                            <div class="preview-text"><?php echo nl2br(htmlspecialchars($offer_text ?: 'Aquí aparecerá el texto de ofertas...')); ?></div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <form id="form-eliminar" action="Aacciones_config.php" method="POST">
            <input type="hidden" name="accion" value="eliminar_ofertas">
        </form>
    </main>
</div>

<script>
    function previewImage(input, previewId) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById(previewId).src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</body>
</html>

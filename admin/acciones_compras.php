<?php
session_start();
require_once "db/conexion.php";

if (!isset($_SESSION['admin_id'])) { header("Location: Alogin.php"); exit(); }

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['order_id'])) {
    $id = $_POST['order_id'];
    $accion = $_POST['accion'] ?? 'actualizar_estado';

    if ($accion === 'eliminar_orden') {
        $stmtCheck = $pdo->prepare("SELECT estado FROM orders WHERE id = ?");
        $stmtCheck->execute([$id]);
        $orden = $stmtCheck->fetch(PDO::FETCH_ASSOC);

        if (!$orden) {
            header("Location: Acompras.php?error=" . urlencode('Orden no encontrada.'));
            exit();
        }

        if ($orden['estado'] !== 'COMPLETADO') {
            header("Location: Adetalle_compra.php?id=" . $id . "&error=" . urlencode('Solo se puede eliminar una orden que esté en estado COMPLETADO.'));
            exit();
        }

        $stmtDelete = $pdo->prepare("DELETE FROM orders WHERE id = ?");
        $stmtDelete->execute([$id]);

        header("Location: Acompras.php?mensaje=" . urlencode('Orden eliminada correctamente.'));
        exit();
    }

    $estado = $_POST['nuevo_estado'];

    $stmt = $pdo->prepare("UPDATE orders SET estado = ? WHERE id = ?");
    $stmt->execute([$estado, $id]);

    header("Location: Adetalle_compra.php?id=" . $id);
    exit();
}
header("Location: Acompras.php");

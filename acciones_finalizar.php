<?php
session_start();
require_once "admin/db/conexion.php";

// Validar sesión
if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['order_uuid'])) {
    
    $uuid = $_POST['order_uuid'];
    $user_id = $_SESSION['user_id'];

    try {
        $stmtOrder = $pdo->prepare("SELECT id FROM orders WHERE order_uuid = ? AND user_id = ?");
        $stmtOrder->execute([$uuid, $user_id]);
        $orden = $stmtOrder->fetch(PDO::FETCH_ASSOC);

        if (!$orden) {
            throw new Exception("Orden no válida.");
        }

        $metodoPago = 'CONTRA_ENTREGA';
        if (!empty($_POST['metodo_pago']) && $_POST['metodo_pago'] === 'CONTRA_ENTREGA') {
            $metodoPago = 'CONTRA_ENTREGA';
        }

        $pdo->beginTransaction();

        $stmtMetodo = $pdo->prepare("UPDATE orders SET metodo_pago = ?, actualizado_en = NOW() WHERE id = ?");
        $stmtMetodo->execute([$metodoPago, $orden['id']]);

        $stmtItems = $pdo->prepare("SELECT producto_id, cantidad FROM order_items WHERE order_id = ?");
        $stmtItems->execute([$orden['id']]);
        $items = $stmtItems->fetchAll(PDO::FETCH_ASSOC);

        descontar_stock_por_orden($pdo, $orden['id']);

        $stmtDelete = $pdo->prepare("DELETE FROM carrito_compras WHERE user_id = ? AND producto_id = ?");
        foreach ($items as $item) {
            $stmtDelete->execute([$user_id, $item['producto_id']]);
        }

        if (isset($_SESSION['carrito']) && !empty($_SESSION['carrito'])) {
            foreach ($_SESSION['carrito'] as $clave => $carrito_item) {
                foreach ($items as $item) {
                    if ((int)$carrito_item['id'] === (int)$item['producto_id']) {
                        unset($_SESSION['carrito'][$clave]);
                        break;
                    }
                }
            }

            if (empty($_SESSION['carrito'])) {
                unset($_SESSION['carrito']);
            }
        }

        $pdo->commit();

        header("Location: pedido_confirmado.php?order=" . $uuid);
        exit();

    } catch (Exception $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        die("Error al finalizar: " . $e->getMessage());
    }

} else {
    header("Location: index.php");
    exit();
}

function descontar_stock_por_orden($pdo, $orderId) {
    $stmtItems = $pdo->prepare("SELECT producto_id, cantidad FROM order_items WHERE order_id = ?");
    $stmtItems->execute([$orderId]);
    $items = $stmtItems->fetchAll(PDO::FETCH_ASSOC);

    foreach ($items as $item) {
        $productoId = $item['producto_id'];
        $cantidadComprada = (int)$item['cantidad'];

        if ($cantidadComprada <= 0) {
            continue;
        }

        $stmtVariantes = $pdo->prepare("SELECT id, stock FROM variantes WHERE producto_id = ? ORDER BY talla");
        $stmtVariantes->execute([$productoId]);
        $variantes = $stmtVariantes->fetchAll(PDO::FETCH_ASSOC);

        if (empty($variantes)) {
            continue;
        }

        $restante = $cantidadComprada;
        foreach ($variantes as $variante) {
            if ($restante <= 0) {
                break;
            }

            $stockActual = (int)$variante['stock'];
            if ($stockActual <= 0) {
                continue;
            }

            $aDescontar = min($restante, $stockActual);
            $restante -= $aDescontar;

            $stmtUpdate = $pdo->prepare("UPDATE variantes SET stock = stock - ? WHERE id = ?");
            $stmtUpdate->execute([$aDescontar, $variante['id']]);
        }

        if ($restante > 0) {
            throw new Exception("No hay suficiente stock para uno de los productos seleccionados.");
        }
    }
}
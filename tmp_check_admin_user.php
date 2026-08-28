<?php
require 'C:/xampp/htdocs/PASANTIAS-USGP-main/admin/db/conexion.php';
$stmt = $pdo->prepare("SELECT id, email, role, estado_cuenta FROM users WHERE role = 'ADMIN' LIMIT 5");
$stmt->execute();
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
var_export($rows);

<?php
require 'config/db.php';

$tablas = ['cliente', 'producto', 'presupuesto', 'factura'];
$titulo = 'Inicio';
require 'includes/header.php';
?>
<h1>Gestor Empresa</h1>
<table>
    <tr><th>Tabla</th><th>Registros</th></tr>
    <?php foreach ($tablas as $tabla): ?>
        <tr>
            <td><?= $tabla ?></td>
            <td><?= $pdo->query("SELECT COUNT(*) FROM $tabla")->fetchColumn() ?></td>
        </tr>
    <?php endforeach; ?>
</table>
<?php require 'includes/footer.php'; ?>

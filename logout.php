<?php require_once 'start.php'; ?>
<?php

    if ($_SESSION['role'] == 'customer') {
        unset($_SESSION['shopping_cart']);
    }

    unset($_SESSION['username']);
    unset($_SESSION['role']);

    header('Location: index.php');
 ?>
 <?php require_once 'app/backend/core/clear.php'; ?>
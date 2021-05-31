<?php
require_once 'app/backend/core/Init.php';
$cart = new Cart();
if ($_SERVER['REQUEST_METHOD'] == 'POST' && $_SERVER['REQUEST_URI'] == '/cart.php') {
    if ($_POST['uid'] && $user && $user->isLoggedIn()) {
        $result = $cart->add($user->data()->uid, $_POST['uid']);
        if ($result) {
            echo json_encode(['data'=>true]);
            return;
        }
    }
    echo json_encode(['error'=>true]);
    return;
}
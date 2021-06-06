<?php
//session_start();
require_once 'app/backend/core/init.php';

if (isset($_POST["add_to_cart"])) {
    if (isLoggedIn() && getRole() == 'customer') {
        if (isset($_SESSION['cart'])) {
            $item_array_id = array_column($_SESSION["cart"], "item_id");

            if (in_array($_GET["id"], $item_array_id)) {
                // echo '<script>alert("Item Already Added")</script>';

                $idx = array_search($_GET["id"], $item_array_id);
                $_SESSION["cart"][$idx]["item_quantity"] += 1;
            } else {
                $item_array = array(
                    'item_id'            =>    $_GET["id"],
                    'item_name'            =>    $_POST["hidden_name"],
                    'item_price'        =>    $_POST["hidden_price"],
                    'item_quantity'        =>    $_POST["quantity"],
                    'item_image'        =>    $_POST["hidden_image"]
                );
                array_Push($_SESSION["cart"], $item_array);
            }
        } else {
            $item_array = array(
                'item_id'            =>    $_GET["id"],
                'item_name'            =>    $_POST["hidden_name"],
                'item_price'        =>    $_POST["hidden_price"],
                'item_quantity'        =>    $_POST["quantity"],
                'item_image'        =>    $_POST["hidden_image"]
            );
            $_SESSION["cart"] = array();
            $_SESSION["cart"][0] = $item_array;
        }
    } else {
        header('Location: login.php');
    }
}

if (isset($_POST["buy_now"])) {
    if (isLoggedIn() && getRole() == 'customer') {
        if (isset($_SESSION['cart'])) {
            $item_array_id = array_column($_SESSION["cart"], "item_id");

            if (in_array($_GET["id"], $item_array_id)) {
                // echo '<script>alert("Item Already Added")</script>';

                $idx = array_search($_GET["id"], $item_array_id);
                $_SESSION["cart"][$idx]["item_quantity"] += 1;
            } else {
                $item_array = array(
                    'item_id'            =>    $_GET["id"],
                    'item_name'            =>    $_POST["hidden_name"],
                    'item_price'        =>    $_POST["hidden_price"],
                    'item_quantity'        =>    $_POST["quantity"],
                    'item_image'        =>    $_POST["hidden_image"]
                );
                array_Push($_SESSION["cart"], $item_array);
            }
        } else {
            $item_array = array(
                'item_id'            =>    $_GET["id"],
                'item_name'            =>    $_POST["hidden_name"],
                'item_price'        =>    $_POST["hidden_price"],
                'item_quantity'        =>    $_POST["quantity"],
                'item_image'        =>    $_POST["hidden_image"]
            );
            $_SESSION["cart"] = array();
            $_SESSION["cart"][0] = $item_array;
        }
        header('Location:cart.php');
    } else {
        header('Location: login.php');
    }
}
?>
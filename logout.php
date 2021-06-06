<?php require_once 'start.php'; ?>
<?php

    if(isset($_SESSION['username']))
        $username = $_SESSION['username'];
        
    if ($_SESSION['role'] == 'customer') {
        $query = "CALL REMOVE_ALL_CART_ITEM(\"$username\")";
        
        if (mysqli_query($conn, $query)) {
            foreach($_SESSION["shopping_cart"] as $keys => $values)
            {
                $bid = $values["item_id"];
                $bquantity = $values["item_quantity"];
                $query = "CALL ADD_TO_CART(\"$username\", \"$bid\",  \"$bquantity\")";

                mysqli_query($conn, $query);
            }
        } else {
            echo "Error deleting record: " . mysqli_error($conn);
        }
        unset($_SESSION['shopping_cart']);
    }

    unset($_SESSION['username']);
    unset($_SESSION['role']);

    header('Location: index.php');
 ?>
 <?php require_once 'app/backend/core/clear.php'; ?>